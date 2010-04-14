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
 * @author c.mahieux@of2m.fr
 * @since 05/04/2010
 */
class Library_HTML
{
    /**
     * Dump server list in HTML select
     *
     * @return String
     */
    public static function serverList()
    {
        # Loading ini file
        $_ini = Library_Configuration::getInstance();

        # Making Servers Select
        $serverList = '<select class="commands" name="request_server"><option value="">All Servers</option>';
        foreach($_ini->get('server') as $server)
        {
            $serverList .= '<option value="' . $server . '">' . $server . '</option>';
        }
        $serverList .= '</select>';
        return $serverList;
    }

    /**
     * Dump api list un HTML select with select name
     *
     * @param String $iniAPI API Name from ini file
     * @param String $id Select ID
     *
     * @return String
     */
    public static function apiList($iniAPI = '', $id)
    {
        return '<select class="commands" name="' . $id . '">
        <option value="Server" ' . self::selected('Server', $iniAPI) . '>Server API</option>
        <option value="Memcache" ' . self::selected('Memcache', $iniAPI) . '>Memcache API</option>
        <option value="Memcached" ' . self::selected('Memcached', $iniAPI) . '>Memcached API</option>
        </select>';
    }

    /**
     * Used to see if an option is selected
     *
     * @param String $actual Actual value
     * @param String $selected Selected value
     *
     * @return String
     */
    private static function selected($actual, $selected)
    {
        if($actual == $selected)
        {
            return 'selected="selected"';
        }
    }
}