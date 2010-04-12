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
$request = (isset($_GET['request_write'])) ? $_GET['request_write'] : null;
$write = null;

# Display by request rype
switch($request)
{
    # Default : No command
    default :

        # Showing header
include 'View/Header.tpl';

# Showing stats frame
include 'View/Live/Frame.tpl';

# Showing footer
include 'View/Footer.tpl';

        # Initializing : taking a snapshot
        $stats = array();
        foreach($_ini['server'] as $server)
        {
            # Spliting server in hostname:port
            $server = preg_split('/:/', $server);
            $stats[$server[0] . ':' . $server[1]] = Library_Analysis::merge($stats, Library_Command_Factory::instance('stats_api')->stats($server[0], $server[1]));
        }

        file_put_contents('Snapshot/' . 'toto', serialize($stats));
        break;
}