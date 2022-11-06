<?php
/**
 * Copyright 2010 Cyrille Mahieux
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations
 * under the License.
 *
 * ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°>
 *
 * Sending command to memcache server
 *
 * @author elijaa@free.fr
 * @since 20/03/2010
 */
namespace App\Library\Command;

use App\Library\App;
use App\Library\Data\Analysis;
use App\Library\Data\Errors;

class Server implements CommandInterface
{
    /**
     * @var App|null
     */
    private static $_ini;

    /**
     * @var string
     */
    private static $_log;

    /**
     * Constructor
     */
    public function __construct()
    {
        self::$_ini = App::getInstance();
    }

    /**
     * @return string
     */
    public function getLog(): ?string
    {
        return static::$_log;
    }

    /**
     * Executing a Command on a MemcacheD Server
     * With the help of http://github.com/memcached/memcached/blob/master/doc/protocol.txt
     * Return the response, or false otherwise
     *
     * @param string $command Command
     * @param string $server Server Hostname
     * @param integer $port Server Port
     *
     * @return string|boolean
     */
    public function exec(string $command, string $server, int $port)
    {
        # Socket Opening
        if (! ($handle = @fsockopen($server, $port, $errno, $errstr, self::$_ini->get('connection_timeout')))) {
            # Adding error to log
            self::$_log = utf8_encode($errstr);
            Errors::add(utf8_encode($errstr));
            return false;
        }

        # Sending Command ...
        fwrite($handle, $command . "\r\n");

        # Getting first line
        $buffer = fgets($handle);

        # Checking if result is valid
        if ($this->end($buffer, $command)) {
            # Closing socket
            fclose($handle);

            # Adding error to log
            self::$_log = $buffer;

            return false;
        }

        # Reading Results
        while (! feof($handle)) {
            # Getting line
            $line = fgets($handle);
            $buffer .= $line;

            # Checking for end of MemCache command
            if ($this->end($line, $command)) {
                break;
            }
        }
        # Closing socket
        fclose($handle);

        return $buffer;
    }

    /**
     * Check if response is at the end from memcached server
     * Return true if response end, true otherwise
     *
     * @param string $buffer Buffer received from memcached server
     * @param string $command Command issued to memcached server
     *
     * @return boolean
     */
    private function end(string $buffer, string $command): bool
    {
        # incr or decr also return integer
        if ((preg_match('/^(incr|decr)/', $command))) {
            if (preg_match('/^(END|ERROR|SERVER_ERROR|CLIENT_ERROR|NOT_FOUND|[0-9]*)/', $buffer)) {
                return true;
            }
        } else {
            # Checking command response end
            if (preg_match('/^(END|DELETED|OK|ERROR|SERVER_ERROR|CLIENT_ERROR|NOT_FOUND|STORED|RESET|TOUCHED)/', $buffer)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Parse result to make an array
     *
     * @param string $string (optional) Parsing stats ?
     * @param bool $stats
     * @return array
     */
    public function parse(string $string, bool $stats = true): array
    {
        # Variable
        $return = array();

        # Exploding by \r\n
        $lines = explode("\r\n", $string);

        # Stats
        if ($stats) {
            # Browsing each line
            foreach ($lines as $line) {
                $data = explode(' ', $line);
                if (isset($data[2])) {
                    $return[$data[1]] = $data[2];
                }
            }
        }         # Items
        else {
            # Browsing each line
            foreach ($lines as $line) {
                $data = explode(' ', $line);
                if (isset($data[1])) {
                    $return[$data[1]] = array(substr($data[2], 1), $data[4]);
                }
            }
        }
        return $return;
    }

    /**
     * Send stats command to server
     * Return the result if successful or false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     *
     * @return array|boolean
     */
    public function stats($server, $port)
    {
        # Executing command
        if (($return = $this->exec('stats', $server, $port))) {
            return $this->parse($return);
        }
        return false;
    }

    /**
     * Send stats settings command to server
     * Return the result if successful or false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     *
     * @return array|boolean
     */
    public function settings($server, $port)
    {
        # Executing command
        if (($return = $this->exec('stats settings', $server, $port))) {
            return $this->parse($return);
        }
        return false;
    }

    /**
     * Send stats items command to server to retrieve slabs stats
     * Return the result if successful or false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     *
     * @return array|boolean
     */
    public function slabs($server, $port)
    {
        # Initializing
        $slabs = array();

        # Finding uptime
        $stats = $this->stats($server, $port);
        $slabs['uptime'] = $stats['uptime'];
        unset($stats);

        $slabs['classes'] = [];

        # Executing command : slabs stats
        if (($result = $this->exec('stats slabs', $server, $port))) {
            # Parsing result
            $result = $this->parse($result);
            $slabs['active_slabs'] = $result['active_slabs'];
            $slabs['total_malloced'] = $result['total_malloced'];
            unset($result['active_slabs']);
            unset($result['total_malloced']);

            # Indexing by slabs
            foreach ($result as $key => $value) {
                $key = explode(':', $key);
                $slabs[$key[0]][$key[1]] = $value;
                $slabs['classes'][$key[0]] = $key[0];
            }

            # Executing command : items stats
            if (($result = $this->exec('stats items', $server, $port))) {
                # Parsing result
                $result = $this->parse($result);

                # Indexing by slabs
                foreach ($result as $key => $value) {
                    $key = explode(':', $key);
                    $slabs[$key[1]]['items:' . $key[2]] = $value;
                }

                return $slabs;
            }
        }
        return false;
    }

    /**
     * @param string $hostname
     * @param string $port
     * @return array
     */
    public function keys(string $hostname, string $port): array
    {
        $slabs = $this->slabs($hostname, $port);

        $res = [];
        foreach ($slabs['classes'] as $class) {
            $slabKeys = $this->items($hostname, $port, $class);
            if ($slabKeys) {
                foreach ($slabKeys as $slabKey => $meta) {
                    $res[] = [
                        'name' => $slabKey,
                        'size' => $meta[0],
                        'ttl' => $meta[1]
                    ];
                }
            }
        }

        usort($res, function(array $a, array $b): int {
            if ($a['name'] === $b['name']) {
                return 0;
            }
            return strcmp($a['name'], $b['name']) <= 0 ? -1 : 1;
        });

        return $res;
    }

    /**
     * Send stats cachedump command to server to retrieve slabs items
     * Return the result if successful or false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param integer $slab Slab ID
     *
     * @return array|boolean
     */
    public function items($server, $port, $slab)
    {
        # Initializing
        $items = false;

        # Executing command : stats cachedump
        if (($result = $this->exec('stats cachedump ' . $slab . ' ' . self::$_ini->get('max_item_dump'), $server, $port))) {
            # Parsing result
            $items = $this->parse($result, false);
        }
        return $items;
    }

    /**
     * Send get command to server to retrieve an item
     * Return the result if successful or false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to retrieve
     *
     * @return string
     */
    public function get($server, $port, $key): string
    {
        # Executing command : get
        if (($string = $this->exec('get ' . $key, $server, $port))) {
            $string = preg_replace('/^VALUE ' . preg_quote($key, '/') . '[0-9 ]*\r\n/', '', $string);
            if (ord($string[0]) == 0x78 && in_array(ord($string[1]), array(0x01, 0x5e, 0x9c, 0xda))) {
                return gzuncompress($string);
            }
            return $string;
        }
        return self::$_log;
    }

    /**
     * Set an item
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to store
     * @param mixed $data Data to store
     * @param integer $duration Duration
     *
     * @return string
     */
    function set($server, $port, $key, $data, $duration)
    {
        # Formatting data
        $data = preg_replace('/\r/', '', $data);

        # Executing command : set
        if (($result = $this->exec('set ' . $key . ' 0 ' . $duration . ' ' . strlen($data) . "\r\n" . $data, $server, $port))) {
            return $result;
        }
        return self::$_log;
    }

    /**
     * Delete an item
     * Return true if successful, false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to delete
     *
     * @return string
     */
    public function delete($server, $port, $key)
    {
        # Executing command : delete
        if (($result = $this->exec('delete ' . $key, $server, $port))) {
            return $result;
        }
        return self::$_log;
    }

    /**
     * Increment the key by value
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to increment
     * @param integer $value Value to increment
     *
     * @return string
     */
    function increment($server, $port, $key, $value)
    {
        # Executing command : increment
        if (($result = $this->exec('incr ' . $key . ' ' . $value, $server, $port))) {
            return $result;
        }
        return self::$_log;
    }

    /**
     * Decrement the key by value
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to decrement
     * @param integer $value Value to decrement
     *
     * @return string
     */
    function decrement($server, $port, $key, $value)
    {
        # Executing command : decrement
        if (($result = $this->exec('decr ' . $key . ' ' . $value, $server, $port))) {
            return $result;
        }
        return self::$_log;
    }

    /**
     * Flush all items on a server
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param integer $delay Delay before flushing server
     *
     * @return string
     */
    function flush_all($server, $port, $delay)
    {
        # Executing command : flush_all
        if (($result = $this->exec('flush_all ' . $delay, $server, $port))) {
            return $result;
        }
        return self::$_log;
    }

    /**
     * Search for item
     * Return all the items matching parameters if successful, false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param $search
     * @param bool $level Level of Detail
     * @param bool $more More action
     *
     * @return array
     */
    function search($server, $port, $search, $level = false, $more = false): array
    {
        $slabs = array();
        $items = false;

        # Executing command : stats
        if ($level === 'full' && ($result = $this->exec('stats', $server, $port))) {
            # Parsing result
            $result = $this->parse($result);
            $infinite = (isset($result['time'], $result['uptime'])) ? ($result['time'] - $result['uptime']) : 0;
        }

        # Executing command : slabs stats
        if (($result = $this->exec('stats slabs', $server, $port))) {
            # Parsing result
            $result = $this->parse($result);
            unset($result['active_slabs']);
            unset($result['total_malloced']);
            # Indexing by slabs
            foreach ($result as $key => $value) {
                $key = explode(':', $key);
                $slabs[$key[0]] = true;
            }
        }

        # Exploring each slabs
        foreach ($slabs as $slab => $unused) {
            # Executing command : stats cachedump
            if (($result = $this->exec('stats cachedump ' . $slab . ' 0', $server, $port))) {
                # Parsing result
                preg_match_all(
                    '/^ITEM ((?:.*)' . preg_quote($search, '/') . '(?:.*)) \[([0-9]*) b; ([0-9]*) s\]\r\n/imU',
                    $result,
                    $matches,
                    PREG_SET_ORDER
                );
                foreach ($matches as $item) {
                    # Search & Delete
                    if ($more == 'delete') {
                        $items[] = $item[1] . ' : ' . $this->delete($server, $port, $item[1]);
                        # Basic search
                    } else {
                        # Detail level
                        if ($level == 'full') {
                            $items[] = $item[1] . ' : [' . trim(Analysis::byteResize($item[2])) . 'b, expire in ' . (($item[3] == $infinite) ? '&#8734;' : Analysis::uptime($item[3] - time(), true)) . ']';
                        } else {
                            $items[] = $item[1];
                        }
                    }
                }
            }
            unset($slabs[$slab]);
        }

        if (is_array($items)) {
            sort($items);
        }

        return $items;
    }

    /**
     * Execute a telnet command on a server
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $command Command to execute
     *
     * @return string
     */
    function telnet($server, $port, $command)
    {
        # Executing command
        $result = $this->exec($command, $server, $port);
        if ($result) {
            return $result;
        }
        return self::$_log;
    }
}
