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
require_once 'Library/Loader.php';

$objects = Library_Data_Builder::instance()->create(MEMCACHE_STATS);

foreach($objects as $object)
{
    foreach($object as $time => $data)
    {
        Library_Data_Builder::instance()->save(MEMCACHE_STATS, $data); # @130ms
    }
}

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Initializing requests
$request = (isset($_GET['request_method'])) ? $_GET['request_method'] : null;

# Display by request type
switch($request)
{
    case 'ajax':
        $return = '[';

        $opts = array(QUERY_START => time() - 3600,
                      QUERY_END => time(),
                      STATS_TYPE => 'hit_rate');

        # Checking stats type request
        if(isset($_GET['stats']) && ($_GET['stats'] != ''))
        {
            switch($_GET['stats'])
            {
                case 'hit_rate':
                    $opts[STATS_TYPE] = 'hit_rate';
                    $opts[STATS_DIFF] = true;
                    break;
                case 'request_seconds':
                    $opts[STATS_TYPE] = 'request_seconds';
                    $opts[STATS_DIFF] = true;
                    break;
                case 'memory_usage':
                    $opts[STATS_TYPE] = 'memory_usage';
                    break;
                case 'network_traffic':
                    $opts[STATS_TYPE] = 'network_traffic';
                    $opts[STATS_DIFF] = true;
                    break;
                case 'current_connections':
                    $opts[STATS_TYPE] = 'current_connections';
                    break;
                case 'eviction_rate';
                    $opts[STATS_TYPE] = 'eviction_rate';
                    $opts[STATS_DIFF] = true;
                    break;
                case 'items_cached';
                    $opts[STATS_TYPE] = 'items_cached';
                    break;
            }
        }

        $objects = Library_Data_Builder::instance()->retreive(MEMCACHE_STATS, $opts);

        //@todo : json_encode > 5.2.0
        foreach($objects as $server => $object)
        {
            $return .= '{label: \'' . $server . '\',';
            $return .= 'data:[';

            # Ordering
            foreach($object as $time => $data)
            {
                $data->analyse($opts[STATS_TYPE]);
                $var = $data->get($opts[STATS_TYPE]);
                $return .= '[' . $time * 1000 . ', ' . round($var) . '],';
            }

            $return .= ']},';
        }
        $return .= ']';
        echo $return;
        break;

        # Default : No command
    default :
        # Showing header
        include 'View/Header.tpl';

        # Showing live stats frame
        include 'View/Graphics/Frame.tpl';

        # Showing footer
        include 'View/Footer.tpl';
        break;
}