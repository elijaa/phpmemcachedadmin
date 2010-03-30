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
 * Factory for comunication with Memcache Server
 *
 * @author c.mahieux@of2m.fr
 * @since 30/03/2010
 */
class MemCacheAdmin_Factory
{
    private static $_object = array();
    private static $_ini;

    /**
     * Constructor
     *
     * @param Array $_ini Parsed ini file
     *
     * @return void
     */
    public function __construct($_ini)
    {
        self::$_ini = $_ini;
    }

    /**
     * Accessor to command class instance
     *
     * @param String $command Type of command
     *
     * @return void
     */
    public static function instance($command)
    {
        # Instance does not exists
        if(!isset(self::$_object[self::$_ini[$command]]))
        {
            # Switching by API
            switch(self::$_ini[$command])
            {
                case 'Memcache':
                    # PECL Memcache API
                    require_once 'MemcacheCommand.php';
                    self::$_object['Memcache'] = new MemCacheAdmin_MemcacheCommand(self::$_ini);
                    break;

                case 'Memcached':
                    # PECL Memcached API
                    require_once 'MemcachedCommand.php';
                    self::$_object['Memcached'] = new MemCacheAdmin_MemcachedCommand(self::$_ini);
                    break;

                case 'Server':
                default:
                    # Server API (eg communicating directly with the memcache server)
                    require_once 'ServerCommand.php';
                    self::$_object['Server'] = new MemCacheAdmin_ServerCommand(self::$_ini);
                    break;
            }
        }
        return self::$_object[self::$_ini[$command]];
    }
}