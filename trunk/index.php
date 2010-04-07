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
require_once 'Library/Command/Interface.php';
require_once 'Library/Command/Factory.php';
require_once 'Library/Analysis.php';
require_once 'Library/Configuration.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Initializing requests
$request = (isset($_GET['show'])) ? $_GET['show'] : null;

# Showing Header
include 'View/Header.tpl';
include 'View/Stats/Menu.tpl';

# Display by Request Type
switch($request)
{
    # Items : Display of all items for a single slab for a single server
    case 'items':
        # Initializing items array
        $items = false;
        $item = null;

        # Ask for one server and one slabs items
        if((isset($_GET['server'])) && (isset($_GET['slab'])))
        {
            $items = Library_Command_Factory::instance('items')->items($_GET['server'], $_ini['server'][$_GET['server']], $_GET['slab']);
        }

        # Cheking if asking an item
        if(isset($_GET['key']))
        {
            $item = Library_Command_Factory::instance('get')->get($_GET['server'], $_ini['server'][$_GET['server']], $_GET['key']);
        }

        # Items are well formed
        if($items !== false)
        {
            include 'View/Stats/Items.tpl';
        }
        # Items are not well formed
        else
        {
            include 'View/Error.tpl';
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
            $slabs = Library_Command_Factory::instance('slabs')->slabs($_GET['server'], $_ini['server'][$_GET['server']]);
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
            include 'View/Error.tpl';
        }
        unset($slabs);
        break;

        # Default : Stats for all or specific single server
    default :
        # Initializing stats array
        $stats = array();

        # Ask for one server stats
        if(isset($_GET['server']))
        {
            $stats = Library_Command_Factory::instance('stats')->stats($_GET['server'], $_ini['server'][$_GET['server']]);
        }
        # Ask for all servers stats
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $stats = Library_Analysis::merge($stats, Library_Command_Factory::instance('stats')->stats($server, $port));
            }
        }

        # Stats are well formed
        if($stats !== false)
        {
            # Analysis
            $stats = Library_Analysis::stats($stats);
            include 'View/Stats/Stats.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'View/Error.tpl';
        }
        unset($stats);
        break;
}
# Showing Footer
include 'View/Footer.tpl';