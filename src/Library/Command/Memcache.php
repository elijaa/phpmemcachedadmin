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
 * Sending command to memcache server via PECL memcache API http://pecl.php.net/package/memcache
 *
 * @author elijaa@free.fr
 * @since 20/03/2010
 */
namespace App\Library\Command;

use App\Library\App;
use Exception;

class Memcache implements CommandInterface
{
    /**
     * @var App|null
     */
    private static $_ini;

    /**
     * @var Memcache
     */
    private static $_memcache;

    /**
     * Constructor
     */
    public function __construct()
    {
        # Importing configuration
        self::$_ini = App::getInstance();

        # Initializing
        self::$_memcache = new Memcache();
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
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command
        if (($return = self::$_memcache->getExtendedStats())) {
            # Delete server key based
            $stats = $return[$server . ':' . $port];
            return $stats;
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
     * @return boolean
     */
    public function settings($server, $port)
    {
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

        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : slabs
        if (($slabs = self::$_memcache->getStats('slabs'))) {
            # Finding uptime
            $stats = $this->stats($server, $port);
            $slabs['uptime'] = $stats['uptime'];
            unset($stats);

            # Executing command : items
            if (($result = self::$_memcache->getStats('items'))) {
                # Indexing by slabs
                foreach ($result['items'] as $id => $items) {
                    foreach ($items as $key => $value) {
                        $slabs[$id]['items:' . $key] = $value;
                    }
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

        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : slabs stats
        if (($items = self::$_memcache->getStats('cachedump', $slab, self::$_ini->get('max_item_dump')))) {
            return $items;
        }
        return false;
    }

    /**
     * Send get command to server to retrieve an item
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to retrieve
     *
     * @return string
     */
    public function get($server, $port, $key)
    {
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : get
        if ($item = self::$_memcache->get($key)) {
            return print_r($item, true);
        }
        return 'NOT_FOUND';
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
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : set
        if (self::$_memcache->set($key, $data, 0, $duration)) {
            return 'STORED';
        }
        return 'ERROR';
    }

    /**
     * Delete an item
     * Return the result
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param string $key Key to delete
     *
     * @return string
     */
    public function delete($server, $port, $key)
    {
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : delete
        if (self::$_memcache->delete($key)) {
            return 'DELETED';
        }
        return 'NOT_FOUND';
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
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : increment
        if ($result = self::$_memcache->increment($key, $value)) {
            return $result;
        }
        return 'NOT_FOUND';
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
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : decrement
        if ($result = self::$_memcache->decrement($key, $value)) {
            return $result;
        }
        return 'NOT_FOUND';
    }

    /**
     * Flush all items on a server
     * Warning, delay won't work with Memcache API
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
        # Adding server
        self::$_memcache->addServer($server, $port);

        # Executing command : flush_all
        self::$_memcache->flush();
        return 'OK';
    }

    /**
     * Search for item
     * Return all the items matching parameters if successful, false otherwise
     *
     * @param string $server Hostname
     * @param integer $port Hostname Port
     * @param $search
     * @param bool $level
     * @param bool $more
     * @return array
     * @throws Exception
     */
    function search($server, $port, $search, $level = false, $more = false)
    {
        throw new Exception('PECL Memcache does not support search function, use Server instead');
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
     * @throws Exception
     */
    function telnet($server, $port, $command)
    {
        throw new Exception('PECL Memcache does not support telnet, use Server instead');
    }
}