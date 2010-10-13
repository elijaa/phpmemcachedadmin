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
 * Stats viewing
 *
 * @author c.mahieux@of2m.fr
 * @since 20/03/2010
 */

# Headers
header('Content-type: text/html; charset=UTF-8');
header('Cache-Control: no-cache, must-revalidate');

# Require
require_once 'Library/Loader.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration_Loader::singleton();

# Initializing requests
$request = (isset($_GET['show'])) ? $_GET['show'] : null;

# Showing header
include 'View/Header.tpl';

# Display by request type
switch($request)
{
    # Items : Display of all items for a single slab for a single server
    case 'items':
        # Initializing items array
        $items = false;
        $response = array();

        # Spliting server in hostname:port
        $server = preg_split('/:/', $_GET['server']);

        # Ask for one server and one slabs items
        if((isset($_GET['server'])) && (isset($_GET['slab'])))
        {
            $items = Library_Command_Factory::instance('items_api')->items($server[0], $server[1], $_GET['slab']);
        }

        # Cheking if asking an item
        if(isset($_GET['request_key']))
        {
            $response[$server[0] . ':' . $server[1]] = Library_Command_Factory::instance('get_api')->get($server[0], $server[1], $_GET['request_key']);
        }

        # Items are well formed
        if($items !== false)
        {
            # Showing items
            include 'View/Stats/Items.tpl';
        }
        # Items are not well formed
        else
        {
            include 'View/Stats/Error.tpl';
        }
        unset($items);
        break;

        # Slabs : Display of all slabs for a single server
    case 'slabs':
        # Initializing slabs array
        $slabs = false;

        # Ask for one server slabs
        if(isset($_GET['server']))
        {
            # Spliting server in hostname:port
            $server = preg_split('/:/', $_GET['server']);
            $slabs = Library_Command_Factory::instance('slabs_api')->slabs($server[0], $server[1]);
        }

        # Slabs are well formed
        if($slabs !== false)
        {
            # Analysis
            $slabs = Library_Analysis::slabs($slabs);
            include 'View/Stats/Slabs.tpl';
        }
        # Slabs are not well formed
        else
        {
            include 'View/Stats/Error.tpl';
        }
        unset($slabs);
        break;

        # Default : Stats for all or specific single server
    default :
        # Initializing stats & settings array
        $stats = array();
        $settings = array();
        $cluster = null;
        $server = null;

        # Ask for a particular cluster stats
        if(isset($_GET['server']) && ($cluster = $_ini->cluster($_GET['server'])))
        {
            foreach($cluster as $server)
            {
                $stats = Library_Analysis::merge($stats, Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']));
            }
        }
        # Asking for a server stats
        elseif(isset($_GET['server']) && ($server = $_ini->server($_GET['server'])))
        {
            $stats = Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']);
            $settings = Library_Command_Factory::instance('stats_api')->settings($server['hostname'], $server['port']);
        }
        # Ask for all servers stats
        else
        {
            # Looking into each cluster
            foreach($_ini->get('servers') as $cluster => $servers)
            {
                # Asking for each server stats
                foreach($servers as $server)
                {
                    $stats = Library_Analysis::merge($stats, Library_Command_Factory::instance('stats_api')->stats($server['hostname'], $server['port']));
                }
            }
        }

        # Stats are well formed
        if(($stats !== false) && ($stats != array()))
        {
            # Analysis
            $stats = Library_Analysis::stats($stats);
            include 'View/Stats/Stats.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'View/Stats/Error.tpl';
        }
        unset($stats);
        break;
}
# Showing footer
include 'View/Footer.tpl';