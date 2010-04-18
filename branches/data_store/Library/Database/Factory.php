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
 * Factory for Database
 *
 * @author c.mahieux@of2m.fr
 * @since 16/04/2010
 */
class Library_Database_Factory
{
    private static $_object = array();

    # No explicit call of constructor
    private function __construct() {}

    # No explicit call of clone()
    private function __clone() {}

    /**
     * Accessor to database class instance
     *
     * @param String $storage Type of storage
     *
     * @return void
     */
    public static function instance($storage)
    {
        # Importing configuration
        $_ini = Library_Configuration::getInstance();

        # Instance does not exists
        if(!isset(self::$_object[$_ini->get($storage)]))
        {
            # Switching by storage type
            switch($_ini->get($storage))
            {
                # SQLite
                case 'SQLite':
                    require_once 'SQLite.php';
                    self::$_object['SQLite'] = new Library_Database_SQLite();
                    break;
                # MySQL
                case 'MySQL':
                    require_once 'MySQL.php';
                    self::$_object['MySQL'] = new Library_Database_MySQL();
                    break;
                # Memcached
                case 'Memcached':
                    require_once 'Memcached.php';
                    self::$_object['Memcached'] = new Library_Database_Memcached();
                    break;
                # FileSystem
                default:
                    self::$_object['File'] = new Library_Database_File();
                    break;
            }
        }
        return self::$_object[$_ini->get($storage)];
    }
}