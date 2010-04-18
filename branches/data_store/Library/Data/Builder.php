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
 * Factory for Stats Objects
 *
 * @author c.mahieux@of2m.fr
 * @since 16/04/2010
 */
class Library_Data_Builder
{
    const TYPE_STATS = 0;
    const TYPE_SLABS = 1;

    private static $_ini;
    private static $_instance;
    private static $_stats = array();

    public static function get($type)
    {
        return self::$_stats;
    }
    /**
     * Get Library_Data_Builder singleton
     *
     * @return Library_Data_Builder
     */
    public static function instance()
    {
        if(!isset(self::$_instance))
        {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    /**
     * Data Builder private constructor
     *
     * @return void
     */
    private function __construct()
    {
        # Loading ini file
        self::$_ini = Library_Configuration::getInstance();
    }

    /**
     * Create data objects of type $type
     *
     * @param String $type Type of data
     * @param String $server Server to ask or all if null
     *
     * @return
     */
    public function create($type, $server = null)
    {
        # Switch by type of request
        switch($type)
        {
            # Asking for stats
            case Library_Data_Builder::TYPE_STATS :
                # Whole cluster
                if(is_null($server))
                {
                    foreach(self::$_ini->cluster() as $server)
                    {
                        # Retreiving Library_Data_Stats object
                        $object = Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']);

                        # Assigning in container
                        self::$_stats[$object->getServer()][$object->getRequestTime()] = $object;
                    }
                }
                # Single server
                else
                {
                    $server = self::$_ini->cluster($server);

                    # Creating stats
                    $object = Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']);

                    # Assigning in container
                    self::$_stats[$object->getServer()][$object->getRequestTime()] = $object;
                }
                break;
        }
    }

    /**
     * Retreive data objects of type $type with time options
     *
     * @param String $type Type of data
     * @param Array $opts Time options
     * @param String $server Server to ask or all if null
     *
     * @return
     */
    public function retreive($type, $opts, $server = null)
    {
        # Switch by type of request
        switch($type)
        {
            # Asking for stats
            case Library_Data_Builder::TYPE_STATS :
                # Retreiving stats
                $stats = Library_Database_Factory::instance('storage')->retreive(Library_Data_Builder::TYPE_STATS);

                # Indexing results
                foreach($stats as $object)
                {
                    self::$_stats[$object->getServer()][$object->getRequestTime()] = $object;
                }
                break;
        }
    }

    /**
     * Save data objects
     *
     * @param String $type Type of data
     * @param Object $object Object to save
     *
     * @return
     */
    public function save($type, $object)
    {
        # Switch by type of request
        switch($type)
        {
            # Asking for stats
            case Library_Data_Builder::TYPE_STATS :
                # Retreiving stats
                Library_Database_Factory::instance('storage')->save($object, Library_Data_Builder::TYPE_STATS);
                break;
        }
    }

}