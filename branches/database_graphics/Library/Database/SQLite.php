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
 * Factory for Database
 *
 * @author c.mahieux@of2m.fr
 * @since 16/04/2010
 */
class Library_Database_SQLite implements Library_Database_Interface
{
    private static $_ini;
    private static $_handle = null;

    /**
     * Constructor
     *
     * @return void
     */
    public function __construct()
    {
        # Importing configuration
        self::$_ini = Library_Configuration::getInstance();

        # Creating connection
        self::$_handle = new SQLiteDatabase(self::$_ini->get('file_path') . DIRECTORY_SEPARATOR . 'phpMemCacheAdmin.db');
    }

    public function save($object, $type)
    {
        # Switch by type of request
        switch($type)
        {
            # Saving stats
            case Library_Data_Builder::TYPE_STATS :
                self::$_handle->queryExec('INSERT INTO stats VALUES(\'' . $object->getServer() . '\',' . $object->getRequestTime() .
                ',' . $object->get('uptime') . ',' . $object->get('curr_connections') . ',' . $object->get('total_connections') .
                ',' . $object->get('connection_structures') . ',' . $object->get('cmd_total') . ',' . $object->get('cmd_set') .
                ',' . $object->get('cmd_flush') . ',' . $object->get('cmd_get') . ',' . $object->get('get_hits') .
                ',' . $object->get('get_misses') . ',' . $object->get('cmd_delete') . ',' . $object->get('delete_hits') .
                ',' . $object->get('delete_misses') . ',' . $object->get('cmd_incr') . ',' . $object->get('incr_hits') .
                ',' . $object->get('incr_misses') . ',' . $object->get('cmd_decr') . ',' . $object->get('decr_hits') .
                ',' . $object->get('decr_misses') . ',' . $object->get('cmd_cas') . ',' . $object->get('cas_hits') .
                ',' . $object->get('cas_misses') . ',' . $object->get('cas_badval') . ',' . $object->get('auth_cmds') .
                ',' . $object->get('auth_errors') . ',' . $object->get('bytes_read') . ',' . $object->get('bytes_written') .
                ',' . $object->get('limit_maxbytes') . ',' . $object->get('accepting_conns') . ',' . $object->get('threads') .
                ',' . $object->get('conn_yields') . ',' . $object->get('bytes') . ',' . $object->get('curr_items') .
                ',' . $object->get('total_items') . ',' . $object->get('evictions') . ',' . $object->get('reclaimed') . ')');
                break;
        }
    }

    public function retreive($type)
    {
        # Switch by type of request
        switch($type)
        {
            # Saving stats
            case Library_Data_Builder::TYPE_STATS :
                $result = self::$_handle->arrayQuery('SELECT count(*) FROM stats', SQLITE_ASSOC);
                var_dump($result);
                //@XXX sqlite_array_query() est plus convenable pour les requêtes retournant 45 lignes ou moins. Si vous attendez plus de données que cela, il est recommandé d'écrire les scripts avec la fonction sqlite_unbuffered_query() pour des performances optimales.
                break;
        }
    }
    /**
     * Create tables
     *
     * @return void
     */
    public function create()
    {
        self::$_handle->query('BEGIN;
                            CREATE TABLE stats (
                            server TEXT,
                            time UNSIGNED INTEGER(8),
                            uptime UNSIGNED INTEGER(8),
                            curr_connections UNSIGNED INTEGER(8),
                            total_connections UNSIGNED INTEGER(8),
                            connection_structures UNSIGNED INTEGER(8),
                            cmd_total UNSIGNED INTEGER(8),
                            cmd_set UNSIGNED INTEGER(8),
                            cmd_flush UNSIGNED INTEGER(8),
                            cmd_get UNSIGNED INTEGER(8),
                            get_hits UNSIGNED INTEGER(8),
                            get_misses UNSIGNED INTEGER(8),
                            cmd_delete UNSIGNED INTEGER(8),
                            delete_hits UNSIGNED INTEGER(8),
                            delete_misses UNSIGNED INTEGER(8),
                            cmd_incr UNSIGNED INTEGER(8),
                            incr_hits UNSIGNED INTEGER(8),
                            incr_misses UNSIGNED INTEGER(8),
                            cmd_decr UNSIGNED INTEGER(8),
                            decr_hits UNSIGNED INTEGER(8),
                            decr_misses UNSIGNED INTEGER(8),
                            cmd_cas UNSIGNED INTEGER(8),
                            cas_hits UNSIGNED INTEGER(8),
                            cas_misses UNSIGNED INTEGER(8),
                            cas_badval UNSIGNED INTEGER(8),
                            auth_cmds UNSIGNED INTEGER(8),
                            auth_errors UNSIGNED INTEGER(8),
                            bytes_read UNSIGNED INTEGER(8),
                            bytes_written UNSIGNED INTEGER(8),
                            limit_maxbytes UNSIGNED INTEGER(8),
                            accepting_conns UNSIGNED INTEGER(8),
                            threads UNSIGNED INTEGER(8),
                            conn_yields UNSIGNED INTEGER(8),
                            bytes UNSIGNED INTEGER(8),
                            curr_items UNSIGNED INTEGER(8),
                            total_items UNSIGNED INTEGER(8),
                            evictions UNSIGNED INTEGER(8),
                            reclaimed UNSIGNED INTEGER(8));
                            COMMIT;');
    }

}