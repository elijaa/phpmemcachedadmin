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
 * Configuration
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
require_once 'Library/HTML.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Initializing requests
$request = (isset($_GET['request_write'])) ? $_GET['request_write'] : null;
$write = null;

# Showing header
include 'View/Header.tpl';

# Display by request rype
switch($request)
{
        # Live stats configuration save
    case 'live_stats':
        # Updating configuration
        $_ini->set('refresh_rate', max(2, $_POST['refresh_rate']));
        $_ini->set('memory_alert', $_POST['memory_alert']);
        $_ini->set('hit_rate_alert', $_POST['hit_rate_alert']);
        $_ini->set('eviction_alert', $_POST['eviction_alert']);
        $_ini->set('file_path', $_POST['file_path']);

        # Writing configuration file
        $write = Library_Configuration::write();
        break;

    # Commands configuration save
    case 'commands':
        # Updating configuration
        $_ini->set('stats_api', $_POST['stats_api']);
        $_ini->set('slabs_api', $_POST['slabs_api']);
        $_ini->set('items_api', $_POST['items_api']);
        $_ini->set('get_api', $_POST['get_api']);
        $_ini->set('set_api', $_POST['set_api']);
        $_ini->set('delete_api', $_POST['delete_api']);
        $_ini->set('flush_all_api', $_POST['flush_all_api']);

        # Writing configuration file
        $write = Library_Configuration::write();
        break;

        # Server configuration save
    case 'servers':
        # Updating configuration
        $_ini->set('server', $_POST['server']);

        # Writing configuration file
        $write = Library_Configuration::write();
        break;

        # Miscellaneous configuration save
    case 'miscellaneous':
        # Updating configuration
        $_ini->set('connection_timeout', $_POST['connection_timeout']);
        $_ini->set('max_item_dump', $_POST['max_item_dump']);

        # Writing configuration file
        $write = Library_Configuration::write();
        break;

        # Default : No command
    default :
        break;
}
# Showing results
include 'View/Response.tpl';

# Showing formulary
include 'View/Configure/Configure.tpl';

# Showing footer
include 'View/Footer.tpl';