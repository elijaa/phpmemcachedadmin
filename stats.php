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
 * Live Stats top style
 *
 * @author c.mahieux@of2m.fr
 * @since 12/04/2010
 */

# Headers
header('Content-type: text/html;');
header('Cache-Control: no-cache, must-revalidate');

# Require
require_once 'Library/Command/Interface.php';
require_once 'Library/Command/Factory.php';
require_once 'Library/Configuration.php';
require_once 'Library/Analysis.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Initializing requests
$request = (isset($_GET['request_command'])) ? $_GET['request_command'] : null;

# Live stats dump file
$file_path = $_ini->get('file_path') . DIRECTORY_SEPARATOR . 'live_stats.' . $_SERVER['REMOTE_ADDR'];

# Display by request type
switch($request)
{
    case 'live_stats':
        # Opening old stats dump
        $oldStats = unserialize(file_get_contents($file_path));

        # Initializing variables
        $newStats = array();
        $stats = array();
        $time = 0;

        # Requesting stats for each server
        foreach($_ini->get('server') as $server)
        {
            # Spliting server in hostname:port
            $server = preg_split('/:/', $server);
            $newStats[$server[0] . ':' . $server[1]] = Library_Command_Factory::instance('stats_api')->stats($server[0], $server[1]);
        }

        # Analysing stats
        foreach($_ini->get('server') as $server)
        {
            # Diff between old and new dump
            $stats[$server] = Library_Analysis::diff($oldStats[$server], $newStats[$server]);
            $time = $stats[$server]['uptime'];

            # Making stats for each server
            foreach($stats as $server => $array)
            {
                $stats[$server] = Library_Analysis::stats($stats[$server]);
                $stats[$server]['bytes_percent'] = $newStats[$server]['bytes_percent'];
                $stats[$server]['curr_connections'] = $newStats[$server]['curr_connections'];
            }
        }

        # Saving new stats dump
        file_put_contents($file_path, serialize($newStats));

        # Showing stats
        include 'View/LiveStats/Stats.tpl';
        break;

        # Default : No command
    default :
        # Showing header
        include 'View/Header.tpl';

        # Showing live stats frame
        include 'View/LiveStats/Frame.tpl';

        # Showing footer
        include 'View/Footer.tpl';

        # Initializing : making stats dump
        $stats = array();
        foreach($_ini->get('server') as $server)
        {
            # Spliting server in hostname:port
            $server = preg_split('/:/', $server);
            $stats[$server[0] . ':' . $server[1]] = Library_Analysis::merge($stats, Library_Command_Factory::instance('stats_api')->stats($server[0], $server[1]));
        }

        # Saving stats dump
        file_put_contents($file_path, serialize($stats));
        chmod($file_path , 0777);
        break;
}