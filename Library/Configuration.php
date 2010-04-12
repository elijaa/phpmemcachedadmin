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
 * Configuration class for editing, saving, ...
 *
 * @author c.mahieux@of2m.fr
 * @since 05/04/2010
 */
class Library_Configuration
{
    private static $_instance = null;
    private static $_iniPath = 'Config/Memcache.ini';
    private static $_iniKeys = array('stats_api',
                                     'slabs_api',
                                     'items_api',
                                     'get_api',
                                     'set_api',
                                     'delete_api',
                                     'flush_all_api',
                                     'server',
                                     'connection_timeout',
                                     'max_item_dump');
    private static $_ini;

    /**
     * Constructor of MemCacheAdmin_Configuration class
     * Load ini file
     *
     * @return Void
     */
    private function __construct()
    {
        # Opening ini file
        self::$_ini = parse_ini_file(self::$_iniPath);

        # Ordering server list
        sort(self::$_ini['server']);
    }

    /**
     * Get MemCacheAdmin_Configuration singleton
     *
     * @return MemCacheAdmin_Configuration
     */
    public static function getInstance()
    {
        if(!isset(self::$_instance))
        {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    /**
     * Config key to retrieve
     *
     * @param Mixed $key Key to get
     *
     * @return Boolean
     */
    public static function get($key)
    {
        return self::$_ini[$key];
    }

    /**
     * Config key to set
     *
     * @param String $key Key to set
     * @param Mixed $value Value to set
     *
     * @return Boolean
     */
    public static function set($key, $value)
    {
        self::$_ini[$key] = $value;
    }

    /**
     * Check if every ini keys are set
     * Return true if ini is correct, false otherwise
     *
     * @return Boolean
     */
    public static function check()
    {
        # Checking configuration keys
        foreach(self::$_iniKeys as $iniKey)
        {
            # Ini file key not set or server not an array @todo Fix the method
            if((!isset(self::$_ini[$iniKey])) || (($iniKey == 'server') && (!is_array(self::$_ini['server']))))
            {
                return false;
            }
        }
        return true;
    }

    /**
     * Write ini file
     * Return true if written, false otherwise
     *
     * @return Boolean
     */
    public static function write()
    {
        if(self::check())
        {
            $iniContent = array();
            foreach(self::$_ini as $iniKey => $iniValue)
            {
                $iniContent[] = '[' . $iniKey . ']';
                if(is_array($iniValue))
                {
                    foreach($iniValue as $subIniValue)
                    {
                        $iniContent[] = $iniKey . '[] = "' . $subIniValue . '"';
                    }
                }
                else
                {
                    $iniContent[] = $iniKey . ' = "' . $iniValue . '"';
                }
            }
            return is_numeric(file_put_contents(self::$_iniPath, implode("\r\n", $iniContent)));
        }
        return false;
    }
}