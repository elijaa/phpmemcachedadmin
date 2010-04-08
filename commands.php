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
 * Executing commands
 *
 * @author c.mahieux@of2m.fr
 * @since 06/04/2010
 */

# Headers
header('Content-type: text/html;');
header('Cache-Control: no-cache, must-revalidate');

# Require
require_once 'Library/Command/Interface.php';
require_once 'Library/Command/Factory.php';
require_once 'Library/Configuration.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Initializing requests
$request = (isset($_GET['request_command'])) ? $_GET['request_command'] : null;
$response = array();

# Showing header
include 'View/Header.tpl';
include 'View/Commands/Menu.tpl';

# Display by request rype
switch($request)
{
    # Memcache::get command
    case 'get':
        # Ask for delete on one server
        if($_GET['request_server'] != '')
        {
            $response[$_GET['request_server'] . ':' . $_ini['server'][$_GET['request_server']]] = Library_Command_Factory::api($_GET['request_api'])->get($_GET['request_server'], $_ini['server'][$_GET['request_server']], $_GET['request_key']);
        }
        # Ask for delete on all servers
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $response[$server . ':' . $_ini['server'][$server]] = Library_Command_Factory::api($_GET['request_api'])->get($server, $_ini['server'][$server], $_GET['request_key']);
            }
        }
        break;

    # Memcache::set command
    case 'set':
        # Ask for delete on one server
        if($_GET['request_server'] != '')
        {
            $response[$_GET['request_server'] . ':' . $_ini['server'][$_GET['request_server']]] = Library_Command_Factory::api($_GET['request_api'])->set($_GET['request_server'], $_ini['server'][$_GET['request_server']], $_GET['request_key'], $_GET['request_data'], $_GET['request_duration']);
        }
        # Ask for delete on all servers
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $response[$server . ':' . $_ini['server'][$server]] = Library_Command_Factory::api($_GET['request_api'])->set($server, $_ini['server'][$server], $_GET['request_key'], $_GET['request_data'], $_GET['request_duration']);
            }
        }
        break;

        # Memcache::delete command
    case 'delete':
        # Ask for delete on one server
        if($_GET['request_server'] != '')
        {
            $response[$_GET['request_server'] . ':' . $_ini['server'][$_GET['request_server']]] = Library_Command_Factory::api($_GET['request_api'])->delete($_GET['request_server'], $_ini['server'][$_GET['request_server']], $_GET['request_key']);
        }
        # Ask for delete on all servers
        else
        {
            foreach($_ini['server'] as $server => $port)
            {
                $response[$server . ':' . $_ini['server'][$server]] = Library_Command_Factory::api($_GET['request_api'])->delete($server, $_ini['server'][$server], $_GET['request_key']);
            }
        }
        break;

        # Default : No command
    default :
        break;
}
# Showing results
    include 'View/Response.tpl';

# Showing formulary
include 'View/Commands/Commands.tpl';

# Showing footer
include 'View/Footer.tpl';