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
 * @author c.mahieux@of2m.fr
 * @since 20/03/2010
 */
class MemCacheAdmin_MemcachedCommands implements MemCacheAdmin_ICommands
{
	private static $_ini;
	private static $_memcache;

	/**
	 * Constructor
	 *
	 * @param Array $ini Array from ini_parse
	 *
	 * @return void
	 */
	public function __construct()
	{
		# Importing configuration
		self::$_ini = MemCacheAdmin_Configuration::getInstance();

		# Initializing
		self::$_memcache = new Memcached();
	}

	/**
	 * Send stats command to server
	 * Return the result if successful or false otherwise
	 *
	 * @param String $server Hostname
	 * @param Integer $port Hostname Port
	 *
	 * @return Array|Boolean
	 */
	public function stats($server, $port)
	{
		# Adding server
		self::$_memcache->addServer($server, $port);

		# Executing command
		if(($return = self::$_memcache->getStats()))
		{
			# Delete server key based
			$stats = $return[$server.':'.$port];

			# Adding value that miss
			$stats['delete_hits'] = '';
			$stats['delete_misses'] = '';
			$stats['incr_hits'] = '';
			$stats['incr_misses'] = '';
			$stats['decr_hits'] = '';
			$stats['decr_misses'] = '';
			$stats['cas_hits'] = '';
			$stats['cas_misses'] = '';
			$stats['cas_badval'] = '';

			return $stats;
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
	 * @return Array|Boolean
	 */
	public function slabs($server, $port)
	{
		throw new Exception('PECL Memcache does not support slabs stats, use Server or Memcache instead');
	}

	/**
	 * Send stats cachedump command to server to retrieve slabs items
	 * Return the result if successful or false otherwise
	 *
	 * @param String $server Hostname
	 * @param Integer $port Hostname Port
	 * @param Interger $slab Slab ID
	 *
	 * @return Array|Boolean
	 */
	public function items($server, $port, $slab)
	{
		throw new Exception('PECL Memcache does not support slabs items stats, use Server or Memcache instead');
	}

	/**
	 * Send get command to server to retrieve an item
	 * Return the result if successful or false otherwise
	 *
	 * @param String $server Hostname
	 * @param Integer $port Hostname Port
	 * @param String $key Key to retrieve
	 *
	 * @return String|Boolean
	 */
	public function get($server, $port, $key)
	{
		# Adding server
		self::$_memcache->addServer($server, $port);

		# Executing command : get
		if($item = self::$_memcache->get($key))
		{
			return print_r($item, true);
		}
		return false;
	}

	/**
	 * Delete an item
	 * Return true if successful, false otherwise
	 *
	 * @param String $server Hostname
	 * @param Integer $port Hostname Port
	 * @param String $key Key to delete
	 *
	 * @return Boolean
	 */
	public function delete($server, $port, $key)
	{
	}
}