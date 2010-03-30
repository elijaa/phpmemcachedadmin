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
 * Sending command to memcache server
 *
 * @author c.mahieux@of2m.fr
 * @since 20/03/2010
 */

# Headers
header('Content-type: text/html; charset=UTF-8');
header('Cache-Control: no-cache, must-revalidate');

# Require
require_once 'library/ICommand.php';
require_once 'library/Factory.php';
require_once 'library/Analysis.php';

# Loading ini file
$_ini = parse_ini_file('config/config.ini');

# Initializing Server List
foreach($_ini['server'] as $key => $server)
{
    $server = explode(':', $server);
    unset($_ini['server'][$key]);
    $_ini['server'][$server[0]] = $server[1];
}

# Date timezone
date_default_timezone_set($_ini['timezone']);

# Initializing Factory
new MemCacheAdmin_Factory($_ini);

# Initializing requests
$request = (isset($_GET['show'])) ? $_GET['show'] : null;
if(isset($_GET['server']) && ($_GET['server'] == 'all'))
{
    unset($_GET['server']);
}

# Showing Header
include 'view/header.tpl';

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
            $items = MemCacheAdmin_Factory::instance('items')->items($_GET['server'], $_ini['server'][$_GET['server']], $_GET['slab']);
        }

        # Cheking if asking an item
        if(isset($_GET['key']))
        {
            $item = MemCacheAdmin_Factory::instance('get')->get($_GET['server'], $_ini['server'][$_GET['server']], $_GET['key']);
        }

        # Items are well formed
        if($items !== false)
        {
            include 'view/items.tpl';
        }
        # Items are not well formed
        else
        {
            include 'view/error.tpl';
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
            $slabs = MemCacheAdmin_Factory::instance('slabs')->slabs($_GET['server'], $_ini['server'][$_GET['server']]);
        }

        # Slabs are well formed
        if($slabs !== false)
        {
            # Analysis
            $slabs = MemCacheAdmin_Analysis::slabs($slabs);
            include 'view/slabs.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'view/error.tpl';
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
            $stats = MemCacheAdmin_Factory::instance('stats')->stats($_GET['server'], $_ini['server'][$_GET['server']]);
        }
        # Ask for all servers stats
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $stats = MemCacheAdmin_Analysis::merge($stats, MemCacheAdmin_Factory::instance('stats')->stats($server, $port));
            }
        }

        # Stats are well formed
        if($stats !== false)
        {
            # Analysis
            $stats = MemCacheAdmin_Analysis::stats($stats);
            include 'view/stats.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'view/error.tpl';
        }
        unset($stats);
        break;
}
# Showing Footer
include 'view/footer.tpl';