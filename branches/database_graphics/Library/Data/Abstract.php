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
 * Object to store stats
 *
 * @author c.mahieux@of2m.fr
 * @since 17/04/2010
 */
abstract class Library_Data_Abstract
{
    protected $_server;
    protected $_port;
    protected $_time;
    protected $_data;

    /**
     * Constructor
     *
     * @param Array $data Stats array
     * @param Integer $time Time of the stats extract
     * @param String $server Server hostname
     * @param Integer $port Server port
     *
     * @return void
     */
    public function __construct($data, $time, $server, $port)
    {
        # Assignation
        $this->_data = $data;
        $this->_time = $time;
        $this->_server = $server;
        $this->_port = $port;

        # Additional analysis
        $this->analyse();
    }

    /**
     * Add additional analysis to stats
     *
     * @return void
     */
    abstract protected function analyse();

    /**
     * Get a stat value
     * Return the value, or 0 if key does not exists
     *
     * @param String $key Key to retreive
     *
     * @return Integer
     */
    public function get($key = null)
    {
        if(is_null($key))
        {
            return $this->_data;
        }

        if(isset($this->_data[$key]))
        {
            return $this->_data[$key];
        }
        return 0;
    }

    /**
     * Return the timestamp when stats were extracted
     *
     * @return Integer
     */
    public function getRequestTime()
    {
        return $this->_time;
    }

    /**
     * Return server hostname:port
     *
     * @return String
     */
    public function getServer()
    {
        return $this->_server . ':' . $this->_port;
    }
}