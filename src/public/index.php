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
 * @author elijaa@free.fr
 * @since 20/03/2010
 */
# Require
use App\Library\Command\Factory;
use App\Library\Data\Analysis;

require_once __DIR__ .'/../bootstrap.php';

# Initializing requests
$request = (isset($_REQUEST['show'])) ? $_REQUEST['show'] : null;

# Getting default cluster
if (! isset($_REQUEST['server'])) {
    $clusters = array_keys($_ini->get('servers'));
    $cluster = isset($clusters[0]) ? $clusters[0] : null;
    $_REQUEST['server'] = $cluster;
}

# Showing header
require __DIR__ .'/../view/header.php';
require __DIR__ .'/../view/server_select.php';

# Display by request type
switch ($request) {
    # Items : Display of all items for a single slab for a single server
    case 'items' :
        # Initializing items array
        $server = null;
        $items = false;

        # Ask for one server and one slabs items
        if (isset($_REQUEST['server']) && ($server = $_ini->server($_REQUEST['server']))) {
            $items = Factory::instance('items_api')->items($server['hostname'], $server['port'], $_REQUEST['slab']);
        }

        # Getting stats to calculate server boot time
        $stats = Factory::instance('stats_api')->stats($server['hostname'], $server['port']);
        $infinite = (isset($stats['time'], $stats['uptime'])) ? ($stats['time'] - $stats['uptime']) : 0;

        # Items are well formed
        if ($items !== false) {
            # Showing items
            require __DIR__ .'/../view/stats/items.php';
        }         # Items are not well formed
        else {
            require __DIR__ .'/../view/stats/error.php';
        }
        unset($items);
        break;

    # Slabs : Display of all slabs for a single server
    case 'slabs' :
        # Initializing slabs array
        $slabs = false;

        # Ask for one server slabs
        if (isset($_REQUEST['server']) && ($server = $_ini->server($_REQUEST['server']))) {
            # Spliting server in hostname:port
            $slabs = Factory::instance('slabs_api')->slabs($server['hostname'], $server['port']);
        }

        # Slabs are well formed
        if ($slabs !== false) {
            # Analysis
            $slabs = Analysis::slabs($slabs);
            require __DIR__ .'/../view/stats/slabs.php';
        }         # Slabs are not well formed
        else {
            require __DIR__ .'/../view/stats/error.php';
        }
        unset($slabs);
        break;

    # Default : Stats for all or specific single server
    default :
        # Initializing stats & settings array
        $stats = array();
        $slabs = array();
        $slabs['total_malloced'] = 0;
        $slabs['total_wasted'] = 0;
        $settings = array();
        $status = array();

        $cluster = null;
        $server = null;

        # Ask for a particular cluster stats
        if (isset($_REQUEST['server']) && ($cluster = $_ini->cluster($_REQUEST['server']))) {
            foreach ($cluster as $name => $server) {
                # Getting Stats & Slabs stats
                $data = array();
                $data['stats'] = Factory::instance('stats_api')->stats($server['hostname'], $server['port']);
                $data['slabs'] = Analysis::slabs(Factory::instance('slabs_api')->slabs($server['hostname'], $server['port']));
                $stats = Analysis::merge($stats, $data['stats']);

                # Computing stats
                if (isset($data['slabs']['total_malloced'], $data['slabs']['total_wasted'])) {
                    $slabs['total_malloced'] += $data['slabs']['total_malloced'];
                    $slabs['total_wasted'] += $data['slabs']['total_wasted'];
                }
                $status[$name] = ($data['stats'] != array()) ? $data['stats']['version'] : '';
                $uptime[$name] = ($data['stats'] != array()) ? $data['stats']['uptime'] : '';
            }
        }        # Asking for a server stats
        elseif (isset($_REQUEST['server']) && ($server = $_ini->server($_REQUEST['server']))) {
            # Getting Stats & Slabs stats
            $stats = Factory::instance('stats_api')->stats($server['hostname'], $server['port']);
            $slabs = Analysis::slabs(Factory::instance('slabs_api')->slabs($server['hostname'], $server['port']));
            $settings = Factory::instance('stats_api')->settings($server['hostname'], $server['port']);
        }

        # Stats are well formed
        if (($stats !== false) && ($stats != array())) {
            # Analysis
            $stats = Analysis::stats($stats);
            require __DIR__ .'/../view/stats/stats.php';
        }         # Stats are not well formed
        else {
            require __DIR__ .'/../view/stats/error.php';
        }
        unset($stats);
        break;
}
# Showing footer
require __DIR__ .'/../view/footer.php';
