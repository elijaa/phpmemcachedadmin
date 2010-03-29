<?php
/**
 * Copyright 2010 Cyrille Mahieux/OFM
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
 * @author Cyrille Mahieux/OFM
 * @since 20/03/2010
 */
# Headers
header('Content-type: text/html; charset=UTF-8');
header('Cache-Control: no-cache, must-revalidate');

require_once 'include/command.php';
require_once 'include/analysis.php';

# Loading ini file
$_ini = parse_ini_file('config/config.ini');

# Initializing Server List
foreach($_ini['server'] as $key => $server)
{
    $server = explode(':', $server);
    unset($_ini['server'][$key]);
    $_ini['server'][$server[0]] = $server[1];
}

# Showing Header
include 'template/header.tpl';

# Initializing
$memCacheAdmin = new MemCache_Command($_ini);
$request = (isset($_GET['show'])) ? $_GET['show'] : null;

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
            $items = $memCacheAdmin->items($_GET['server'], $_ini['server'][$_GET['server']], $_GET['slab']);
        }

        # Cheking if asking an item
        if(isset($_GET['key']))
        {
            $item = $memCacheAdmin->get($_GET['server'], $_ini['server'][$_GET['server']], $_GET['key']);
        }

        # Items are well formed
        if($items !== false)
        {
            include 'template/items.tpl';
        }
        # Items are not well formed
        else
        {
            include 'template/error.tpl';
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
            $slabs = $memCacheAdmin->slabs($_GET['server'], $_ini['server'][$_GET['server']]);
        }

        # Slabs are well formed
        if($slabs !== false)
        {
            # Analysis
            $slabs = MemCache_Analysis::slabs($slabs);
            include 'template/slabs.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'template/error.tpl';
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
            $stats = $memCacheAdmin->stats($_GET['server'], $_ini['server'][$_GET['server']]);
        }
        # Ask for all servers stats
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $stats = MemCache_Analysis::merge($stats, $memCacheAdmin->stats($server, $port));
            }
        }

        # Stats are well formed
        if($stats !== false)
        {
            # Analysis
            $stats = MemCache_Analysis::stats($stats);
            include 'template/stats.tpl';
        }
        # Stats are not well formed
        else
        {
            include 'template/error.tpl';
        }
        unset($stats);
        break;
}
# Showing Footer
include 'template/footer.tpl';