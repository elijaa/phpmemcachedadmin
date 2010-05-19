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
 * Abstract configuration class for editing, saving, ...
 *
 * @author c.mahieux@of2m.fr
 * @since 19/05/2010
 */
class Library_Configuration_Loader
{
    protected static $_instance = null;
    protected static $_iniPath = './Config/Memcache.php';
    protected static $_iniKeys = array();
    protected static $_ini = array();
    protected static $_clusters = array();
    protected static $_servers = array();

    /**
     * Constructor of MemCacheAdmin_Configuration class
     * Load ini file
     *
     * @return Void
     */
    protected function __construct()
    {
        # Opening ini file
        self::$_ini = require self::$_iniPath;

        # Spliting server in hostname:port
        foreach(self::$_ini['clusters'] as $cluster => $servers)
        {
            foreach($servers as $server)
            {
                $array = preg_split('/:/', $server);
                self::$_clusters[$cluster][$server] = array('hostname' => $array[0], 'port' => $array[1]);
            }
        }
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
     * @param String $key Key to get
     *
     * @return Mixed
     */
    public function get($key)
    {
        return self::$_ini[$key];
    }

    public function clusters()
    {
        return array_keys(self::$_clusters);
    }

    public function servers($cluster = null)
    {
        if($cluster == null)
        {
            if(self::$_servers == array())
            {
                foreach(self::$_clusters as $servers)
                {
                    foreach($servers as $server => $data)
                    {
                        self::$_servers[$server] = $data;
                    }
                }
            }
            return self::$_servers;
        }
        return array_values(self::$_clusters[$cluster]);
    }

    /**
     * Config key to set
     *
     * @param String $key Key to set
     * @param Mixed $value Value to set
     *
     * @return Boolean
     */
    public function set($key, $value)
    {
        self::$_ini[$key] = $value;
    }

    /**
     * Check if every ini keys are set
     * Return true if ini is correct, false otherwise
     *
     * @return Boolean
     */
    public function check()
    {
        # Checking configuration keys
        foreach(self::$_iniKeys as $iniKey)
        {
            # Ini file key not set
            if(!isset(self::$_ini[$iniKey]))
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
    public function write()
    {
        if($this->check())
        {
            return is_numeric(file_put_contents(self::$_iniPath, '<?php' . PHP_EOL . 'return ' . var_export(self::$_ini, true) . ';'));
        }
        return false;
    }
}