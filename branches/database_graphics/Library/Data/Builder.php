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
 * Builder of Stats Objects
 *
 * @author c.mahieux@of2m.fr
 * @since 16/04/2010
 */
class Library_Data_Builder
{
    private static $_ini;
    private static $_instance;

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
     * Return the array
     *
     * @param String $type Type of data
     * @param String $server Server to ask or all if null
     *
     * @return Array
     */
    public function create($type, $server = null)
    {
        $array = array();

        # Switch by type of request
        switch($type)
        {
            # Asking for stats
            case MEMCACHE_STATS :
                # Whole cluster
                if(is_null($server))
                {
                    foreach(self::$_ini->cluster() as $server)
                    {
                        # Retreiving Library_Data_Stats object
                        $object = Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']);

                        # Assigning in container
                        $array[$object->getServer()][$object->getRequestTime()] = $object;
                    }
                }
                # Single server
                else
                {
                    $server = self::$_ini->cluster($server);

                    # Creating stats
                    $object = Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']);

                    # Assigning in container
                    $array[$object->getServer()][$object->getRequestTime()] = $object;
                }
                break;
        }

        return $array;
    }

    /**
     * Retreive data objects of type $type with time options
     * Return an array
     *
     * @param String $type Type of data
     * @param Array $opts Time options
     * @param String $server Server to ask or all if null
     *
     * @return Array
     */
    public function retreive($type, $opts, $server = null)
    {
        $array = array();

        # Switch by type of request
        switch($type)
        {
            # Asking for stats
            case MEMCACHE_STATS :
                # Retreiving stats
                $objects = Library_Database_Factory::instance('storage')->retreive(MEMCACHE_STATS, $opts);

                # Indexing results
                foreach($objects as $object)
                {
                    $array[$object->getServer()][$object->getRequestTime()] = $object;
                }

                # Diff option
                if(isset($opts[STATS_DIFF]))
                {
                    # Analysing for each server
                    foreach($array as $server => $data)
                    {
                        # Initializing time - 1 values
                        $previousTime = null;
                        $previousStats = null;

                        # Analysing for each stat object
                        foreach($data as $time => $object)
                        {
                            # Not first pass
                            if($previousTime != null)
                            {
                                # Calculing difference between previous and actual stats
                                $diff = Library_Analysis::diff($data[$previousTime]->get(), $data[$time]->get());

                                # Adding previous statistic diff to previous stats object
                                $array[$server][$previousTime]->set($previousStats);

                                # Moving previous stats with actual diff
                                $previousStats = $diff;
                                $previousTime = $time;
                            }
                            # First pass, initializing previous stats
                            else
                            {
                                $previousTime = $time;
                                $previousStats = $object->get();
                            }
                        }

                        # Last object
                        $array[$server][$previousTime]->set($previousStats);
                        //array_shift($array[$server]); # @FIXME
                    }
                }
                break;
        }

        return $array;
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
            case MEMCACHE_STATS :
                # Retreiving stats
                Library_Database_Factory::instance('storage')->save($object, MEMCACHE_STATS);
                break;
        }
    }
}