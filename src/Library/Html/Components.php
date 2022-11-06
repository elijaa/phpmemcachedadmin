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
 * Manipulation of HTML
 *
 * @author elijaa@free.fr
 * @since 05/04/2010
 */
namespace App\Library\Html;

use App\Library\App;

class Components
{
    /**
     * Dump server list in an HTML select
     *
     * @param $name
     * @param string|null $selected
     * @param string|null $class
     * @param string|null $events
     * @return string
     */
    public static function serverSelect($name, ?string $selected = '', ?string $class = '', ?string $events = ''): string
    {
        # Loading ini file
        $_ini = App::getInstance();

        # Select Name
        $serverList = '<select id="'. htmlspecialchars($name, ENT_QUOTES) .'" ';

        # CSS Class
        if ($class) {
            $serverList .= 'class="'. $class .'"';
        }

        # Javascript Events
        if ($events) {
            $serverList .= ' ' . $events . '>';
        }

        foreach ($_ini->get('servers') as $cluster => $servers) {
            # Cluster
            $serverList .= '<option value="' . htmlspecialchars($cluster, ENT_QUOTES) . '"';
            $serverList .= ($selected == $cluster) ? ' selected="selected"' : null;
            $serverList .= '>' . htmlspecialchars($cluster) . ' cluster</option>';

            # Cluster server
            foreach ($servers as $name => $servers2) {
                $serverList .= '<option value="' . $name . '"';
                $serverList .= ($selected === $name) ? ' selected="selected"' : null;
                $serverList .= '>&nbsp;&nbsp;-&nbsp;' . (mb_strlen($name) > 38 ? mb_substr($name, 0, 38) .' [...]' : $name) .'</option>';
            }
        }
        return $serverList . '</select>';
    }

    /**
     * Dump cluster list in an HTML select
     *
     * @param $name
     * @param string $selected
     * @param string $class
     * @param string $events
     * @return string
     */
    public static function clusterSelect($name, string $selected = '', string $class = '', string $events = ''): string
    {
        # Loading ini file
        $_ini = App::getInstance();

        # Select Name
        $clusterList = '<select id="'. htmlspecialchars($name, ENT_QUOTES) .'" ';

        # CSS Class
        if ($class) {
            $clusterList .= 'class="'. $class .'"';
        }

        # Javascript Events
        if ($events) {
            $clusterList .= ' ' . $events . '>';
        }

        foreach ($_ini->get('servers') as $cluster => $servers) {
            # Option value and selected case
            $clusterList .= '<option value="'. htmlspecialchars($cluster, ENT_QUOTES) .'"';
            $clusterList .= ($selected == $cluster) ? ' selected="selected"' : null;
            $clusterList .= '>'. htmlspecialchars($cluster) .' cluster</option>';
        }
        return $clusterList .'</select>';
    }

    /**
     * Dump server response in proper formatting
     *
     * @param string $hostname Hostname
     * @param string $port Port
     * @param mixed $data Data (response)
     *
     * @return string
     */
    public static function serverResponse(string $hostname, string $port, $data): string
    {
        $header = '<span class="red">Server '. $hostname .':'. $port ."</span>\r\n";
        $return = '';
        if (is_array($data)) {
            foreach ($data as $string) {
                $return .= $string . "\r\n";
            }
            return $header . htmlentities($return, ENT_NOQUOTES | 0, 'UTF-8') . "\r\n";
        }
        return $header . $return . $data . "\r\n";
    }

    /**
     * Dump api list un HTML select with select name
     *
     * @param string $iniAPI API Name from ini file
     * @param string|null $id Select ID
     *
     * @return string
     */
    public static function apiList(string $iniAPI = '', string $id = null): string
    {
        return '<select id="' . htmlspecialchars($id, ENT_QUOTES) . '" name="' . htmlspecialchars($id, ENT_QUOTES) . '">
                <option value="Server"'. self::selected('Server', $iniAPI) .'>Server API</option>
                <option value="Memcache"'. self::selected('Memcache', $iniAPI) .'>Memcache API</option>
                <option value="Memcached"'. self::selected('Memcached', $iniAPI) .'>Memcached API</option>
                </select>';
    }

    /**
     * Used to see if an option is selected
     *
     * @param string $actual Actual value
     * @param string $selected Selected value
     *
     * @return string|null
     */
    private static function selected(string $actual, string $selected): ?string
    {
        if ($actual === $selected) {
            return ' selected="selected"';
        }
        return null;
    }
}