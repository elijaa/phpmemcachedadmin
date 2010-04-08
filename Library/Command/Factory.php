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
class Library_Command_Factory
{
    private static $_object = array();

    /**
     * Accessor to command class instance by command type
     *
     * @param String $command Type of command
     *
     * @return void
     */
    public static function instance($command)
    {
        # Importing configuration
        $_ini = Library_Configuration::getInstance();

        # Instance does not exists
        if(!isset(self::$_object[$_ini[$command]]))
        {
            # Switching by API
            switch($_ini[$command])
            {
                case 'Memcache':
                    # PECL Memcache API
                    require_once 'Memcache.php';
                    self::$_object['Memcache'] = new Library_Command_Memcache();
                    break;

                case 'Memcached':
                    # PECL Memcached API
                    require_once 'Memcached.php';
                    self::$_object['Memcached'] = new Library_Command_Memcached();
                    break;

                case 'Server':
                default:
                    # Server API (eg communicating directly with the memcache server)
                    require_once 'Server.php';
                    self::$_object['Server'] = new Library_Command_Server();
                    break;
            }
        }
        return self::$_object[$_ini[$command]];
    }

    /**
     * Accessor to command class instance by type
     *
     * @param String $command Type of command
     *
     * @return void
     */
    public static function api($api)
    {
        # Importing configuration
        $_ini = Library_Configuration::getInstance();

        # Instance does not exists
        if(!isset(self::$_object[$api]))
        {
            # Switching by API
            switch($api)
            {
                case 'Memcache':
                    # PECL Memcache API
                    require_once 'Memcache.php';
                    self::$_object['Memcache'] = new Library_Command_Memcache();
                    break;

                case 'Memcached':
                    # PECL Memcached API
                    require_once 'Memcached.php';
                    self::$_object['Memcached'] = new Library_Command_Memcached();
                    break;

                case 'Server':
                default:
                    # Server API (eg communicating directly with the memcache server)
                    require_once 'Server.php';
                    self::$_object['Server'] = new Library_Command_Server();
                    break;
            }
        }
        return self::$_object[$api];
    }
}