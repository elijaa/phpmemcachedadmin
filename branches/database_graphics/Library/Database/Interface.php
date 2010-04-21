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
 * Interface of database
 *
 * @author c.mahieux@of2m.fr
 * @since 17/04/2010
 */
interface Library_Database_Interface
{
    /**
     * Constructor
     *
     * @return void
     */
    function __construct();

    /**
     * Create the complete database structure
     *
     * @return void
     */
    function create();

    /**
     * Save an object into database
     * Return true if sucessfull, false otherwise
     *
     * @param Library_Data_Stats $object Stats object
     * @param Integer $type Type of data
     *
     * @return Boolean
     */
    function save($object, $type);

    /**
     * Retreive objects from database with options
     * Return objects
     *
     * @param Integer $type Type of data
     * @param Array $opts Options of retreival
     *
     * @return Array
     */
    function retreive($type, $opts = array());
}