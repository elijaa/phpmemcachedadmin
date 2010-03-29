<?php
/**
 * Copyright 2010 Cyrille Mahieux/OFM
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
 * _/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_
 *
 * Sending command to memcache server
 *
 * @author Cyrille Mahieux/OFM
 * @since 20/03/2010
 */
class MemCache_Command
{
    private static $_ini;

    /**
     * Constructor
     *
     * @param Array $ini Array from ini_parse
     *
     * @return void
     */
    public function __construct($ini)
    {
        self::$_ini = $ini;
    }

    /**
     * Executing a Command on a MemCache Server
     * With the help of http://github.com/memcached/memcached/blob/master/doc/protocol.txt
     * Return the response, or false otherwise
     *
     * @param String $command Command
     * @param String $server Server Hostname
     * @param Interger $port Server Port
     *
     * @return String|boolean
     */
    protected function exec($command, $server, $port)
    {
        # Variables
        $buffer = '';
        $handle = null;

        # Socket Opening
        if(!($handle = fsockopen($server, $port, $errno, $errstr, self::$_ini['connection_timeout'])))
        {
            return false;
        }

        # Sending Command ...
        fwrite($handle, $command . "\r\n");

        # Getting first line
        $buffer = fgets($handle);

        # Checking if result is valid
        if(strpos($buffer, 'END') !== false)
        {
            return false;
        }

        # Reading Results
        while((!feof($handle)))
        {
            $buffer .= fgets($handle);

            # End of MemCache stats command
            if(strpos($buffer, 'END') !== false)
            {
                break;
            }

            # End of MemCache delete command
            if(strpos($buffer, 'DELETED') != false || strpos($buffer,'NOT_FOUND') != false)
            {
                break;
            }
            if(strpos($buffer, 'OK') != false)
            {
                break;
            }

            # End of MemCache error result
            if(strpos($buffer, 'ERROR') != false)
            {
                break;
            }
            if(strpos($buffer, 'SERVER_ERROR') != false)
            {
                break;
            }
            if(strpos($buffer, 'CLIENT_ERROR') != false)
            {
                break;
            }
        }
        # Closing socket
        fclose($handle);

        return $buffer;
    }

    /**
     * Parse result to make an array
     *
     * @param String $string String to parse
     * @param boolean $string (optionnal) Parsing stats ?
     *
     * @return Array
     */
    private function parse($string, $stats = true)
    {
        # Variable
        $return = array();

        # Exploding by \r\n
        $lines = explode("\r\n", $string);

        # Stats
        if($stats)
        {
            # Browsing each line
            foreach($lines as $line)
            {
                $data = explode(' ', $line);
                if(isset($data[2]))
                {
                    $return[$data[1]] = $data[2];
                }
            }
        }
        # Items
        else
        {
            # Browsing each line
            foreach($lines as $line)
            {
                $data = explode(' ', $line);
                if(isset($data[1]))
                {
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
     * @param String $server Hostname
     * @param Integer $port Hostname Port
     *
     * @return String
     */
    public function stats($server, $port)
    {
        # Executing command
        if(($return = $this->exec('stats', $server, $port)))
        {
            return $this->parse($return);
        }
        return false;
    }

    /**
     * Send stats items command to server to retrieve slabs stats
     * Return the result if successful or false otherwise
     *
     * @param String $server Hostname
     * @param Integer $port Hostname Port
     *
     * @return String
     */
    public function slabs($server, $port)
    {
        # Initializing
        $slabs = array();

        # Finding uptime
        $stats = $this->stats($server, $port);
        $slabs['uptime'] = $stats['uptime'];
        unset($stats);

        # Executing command : slabs stats
        if(($result = $this->exec('stats slabs', $server, $port)))
        {
            # Parsing result
            $result = $this->parse($result);
            $slabs['active_slabs'] = $result['active_slabs'];
            $slabs['total_malloced'] = $result['total_malloced'];
            unset($result['active_slabs']);
            unset($result['total_malloced']);

            # Indexing by slabs
            foreach($result as $key => $value)
            {
                $key = explode(':', $key);
                $slabs[$key[0]][$key[1]] = $value;
            }

            # Executing command : items stats
            if(($result = $this->exec('stats items', $server, $port)))
            {
                # Parsing result
                $result = $this->parse($result);

                # Indexing by slabs
                foreach($result as $key => $value)
                {
                    $key = explode(':', $key);
                    $slabs[$key[1]]['items:' . $key[2]] = $value;
                }

                return $slabs;
            }
        }
        return false;
    }

    /**
     * Send stats cachedump command to server to retrieve slabs items
     * Return the result if successful or false otherwise
     *
     * @param String $server Hostname
     * @param Integer $port Hostname Port
     * @param Interger $slab Slab ID
     *
     * @return String
     */
    public function items($server, $port, $slab)
    {
        # Initializing
        $items = false;

        # Executing command : stats cachedump
        if(($result = $this->exec('stats cachedump ' . $slab . ' ' . self::$_ini['max_item_dump'], $server, $port)))
        {
            # Parsing result
            $items = $this->parse($result, false);
        }
        return $items;
    }

    /**
     * Send get command to server to retrieve an item
     * Return the result if successful or false otherwise
     *
     * @param String $server Hostname
     * @param Integer $port Hostname Port
     * @param String $key Key to retrieve
     *
     * @return String
     */
    public function get($server, $port, $key)
    {
        # Executing command : get
        if($string = $this->exec('get ' . $key, $server, $port))
        {
            # Exploding by \r\n
            $lines = explode("\r\n", $string);

            return $lines[1];
        }
        return false;
    }
}