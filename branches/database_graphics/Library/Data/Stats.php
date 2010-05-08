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
 * Object to store stats
 *
 * @author c.mahieux@of2m.fr
 * @since 17/04/2010
 */
class Library_Data_Stats
{
    protected $_server;
    protected $_port;
    protected $_time;
    protected $_data;

    /**
     * Constructor
     *
     * @param Array $data Stats array
     * @param Integer $time Time of the stats extract
     * @param String $server Server hostname
     * @param Integer $port Server port
     *
     * @return void
     */
    public function __construct($data, $time, $server, $port)
    {
        # Assignation
        $this->_data = $data;
        $this->_time = $time;
        $this->_server = $server;
        $this->_port = $port;
    }

    /**
     * Add additional analysis to stats
     *
     * @param Integer $opts Analyse options
     *
     * @return void
     */
    public function analyse($opts)
    {
        if($this->_data['uptime'] == 0)
        {
        	$this->_data['uptime'] = 1;
        }
        /*
                case 'hit_rate':
                case 'request_seconds':
                case 'memory_usage':
                case 'network_traffic':
                case 'current_connections':
                case 'eviction_rate';
                case 'items_cached'; */
        switch($opts)
        {
            case 'network_traffic':
            case 'current_connections':
            case 'items_cached':
                break;
/**
            case 'cmd_set':
                # Command set()
                $this->_data['set_rate'] = ($this->_data['cmd_set'] == 0) ? '0.0' : number_format($this->_data['cmd_set'] / $this->_data['uptime'], 1);
                break;

            case 'cmd_get':
                # Command get()
                $this->_data['get_hits_percent'] = ($this->_data['cmd_get'] == 0) ? ' - ' : number_format($this->_data['get_hits'] / $this->_data['cmd_get'] * 100, 1);
                $this->_data['get_misses_percent'] = ($this->_data['cmd_get'] == 0) ? ' - ' : number_format($this->_data['get_misses'] / $this->_data['cmd_get'] * 100, 1);
                $this->_data['get_rate'] = ($this->_data['cmd_get'] == 0) ? 0 : number_format($this->_data['cmd_get'] / $this->_data['uptime'], 1);
                break;

            case 'cmd_delete':
                # Command delete()
                $this->_data['cmd_delete'] = $this->_data['delete_hits'] + $this->_data['delete_misses'];
                $this->_data['delete_hits_percent'] = ($this->_data['cmd_delete'] == 0) ? ' - ' : number_format($this->_data['delete_hits'] / $this->_data['cmd_delete'] * 100, 1);
                $this->_data['delete_misses_percent'] = ($this->_data['cmd_delete'] == 0) ? ' - ' : number_format($this->_data['delete_misses'] / $this->_data['cmd_delete'] * 100, 1);
                $this->_data['delete_rate'] = ($this->_data['cmd_delete'] == 0) ? 0 : number_format($this->_data['cmd_delete'] / $this->_data['uptime'], 1);
                break;

            case 'cmd_cas':
                # Command cas()
                $this->_data['cmd_cas'] = $this->_data['cas_hits'] + $this->_data['cas_misses'] + $this->_data['cas_badval'];
                $this->_data['cas_hits_percent'] = ($this->_data['cmd_cas'] == 0) ?' - ':number_format($this->_data['cas_hits'] / $this->_data['cmd_cas'] * 100, 1);
                $this->_data['cas_misses_percent'] = ($this->_data['cmd_cas'] == 0) ?' - ':number_format($this->_data['cas_misses'] / $this->_data['cmd_cas'] * 100, 1);
                $this->_data['cas_badval_percent'] = ($this->_data['cmd_cas'] == 0) ?' - ':number_format($this->_data['cas_badval'] / $this->_data['cmd_cas'] * 100, 1);
                $this->_data['cas_rate'] = ($this->_data['cmd_cas'] == 0) ? '0.0':number_format($this->_data['cmd_cas'] / $this->_data['uptime'], 1);
                break;

            case 'cmd_incr':
                # Command increment()
                $this->_data['cmd_incr'] = $this->_data['incr_hits'] + $this->_data['incr_misses'];
                $this->_data['incr_hits_percent'] = ($this->_data['cmd_incr'] == 0) ? ' - ' : number_format($this->_data['incr_hits'] / $this->_data['cmd_incr'] * 100, 1);
                $this->_data['incr_misses_percent'] = ($this->_data['cmd_incr'] == 0) ? ' - ' : number_format($this->_data['incr_misses'] / $this->_data['cmd_incr'] * 100, 1);
                $this->_data['incr_rate'] = ($this->_data['cmd_incr'] == 0) ? 0 : number_format($this->_data['cmd_incr'] / $this->_data['uptime'], 1);
                break;

            case 'cmd_decr':
                # Command decrement()
                $this->_data['cmd_decr'] = $this->_data['decr_hits'] + $this->_data['decr_misses'];
                $this->_data['decr_hits_percent'] = ($this->_data['cmd_decr'] == 0) ? ' - ' : number_format($this->_data['decr_hits'] / $this->_data['cmd_decr'] * 100, 1);
                $this->_data['decr_misses_percent'] = ($this->_data['cmd_decr'] == 0) ? ' - ' : number_format($this->_data['decr_misses'] / $this->_data['cmd_decr'] * 100, 1);
                $this->_data['decr_rate'] = ($this->_data['cmd_decr'] == 0) ? 0 : number_format($this->_data['cmd_decr'] / $this->_data['uptime'], 1);
                break;
*/
            case 'memory_usage':
                # Cache size
                $this->_data['bytes_percent'] = ($this->_data['limit_maxbytes'] == 0) ? 0 : round($this->_data['bytes'] / $this->_data['limit_maxbytes'] * 100, 1);
                break;

            case 'hit_rate':
            case 'request_seconds':
                # Request rate
                $this->_data['cmd_delete'] = $this->_data['delete_hits'] + $this->_data['delete_misses'];
                $this->_data['cmd_cas'] = $this->_data['cas_hits'] + $this->_data['cas_misses'] + $this->_data['cas_badval'];
                $this->_data['cmd_incr'] = $this->_data['incr_hits'] + $this->_data['incr_misses'];
                $this->_data['cmd_decr'] = $this->_data['decr_hits'] + $this->_data['decr_misses'];
                $this->_data['cmd_total'] = $this->_data['cmd_get'] + $this->_data['cmd_set'] + $this->_data['cmd_delete'] + $this->_data['cmd_cas'] + $this->_data['cmd_incr'] + $this->_data['cmd_decr'];

                $this->_data['hit_percent'] = ($this->_data['cmd_total'] == 0) ? 0 : round(($this->_data['cmd_set'] + $this->_data['get_hits'] + $this->_data['delete_hits'] + $this->_data['cas_hits'] + $this->_data['incr_hits'] + $this->_data['decr_hits']) / $this->_data['cmd_total'] * 100, 1);
                $this->_data['miss_percent'] = ($this->_data['cmd_total'] == 0) ? 0 : round(($this->_data['get_misses'] + $this->_data['delete_misses'] + $this->_data['cas_misses'] + $this->_data['cas_badval'] + $this->_data['incr_misses'] + $this->_data['decr_misses']) / $this->_data['cmd_total'] * 100, 1);

                $this->_data['request_rate'] = round(($this->_data['cmd_get'] + $this->_data['cmd_set'] + $this->_data['cmd_delete'] + $this->_data['cmd_cas'] + $this->_data['cmd_incr'] + $this->_data['cmd_decr']) / $this->_data['uptime'], 1);
                $this->_data['hit_rate'] = round(($this->_data['cmd_set'] + $this->_data['get_hits'] + $this->_data['delete_hits'] + $this->_data['cas_hits'] + $this->_data['incr_hits'] + $this->_data['decr_hits']) / $this->_data['uptime'], 1);
                $this->_data['miss_rate'] = round(($this->_data['get_misses'] + $this->_data['delete_misses'] + $this->_data['cas_misses'] + $this->_data['cas_badval'] + $this->_data['incr_misses'] + $this->_data['decr_misses']) / $this->_data['uptime'], 1);
                break;

            case 'eviction_rate':
                # Eviction & reclaimed rate
                $this->_data['eviction_rate'] = ($this->_data['evictions'] == 0) ? 0 : round($this->_data['evictions'] / $this->_data['uptime'], 1);
                $this->_data['reclaimed_rate'] = (!isset($this->_data['reclaimed']) || ($this->_data['reclaimed'] == 0)) ? 0 : round($this->_data['reclaimed'] / $this->_data['uptime'], 1);
                break;
        }
    }

    /**
     * Get a stat value
     * Return the value, or 0 if key does not exists
     *
     * @param String $key Key to retreive
     *
     * @return Integer
     */
    public function get($key = null)
    {
        if(is_null($key))
        {
            return $this->_data;
        }

        if(isset($this->_data[$key]))
        {
            return $this->_data[$key];
        }
        return 0;
    }

    /**
     * Set stats values
     *
     * @param Array $data Stats
     *
     * @return void
     */
    public function set($data)
    {
        $this->_data = $data;
    }

    /**
     * Return the timestamp when stats were extracted
     *
     * @return Integer
     */
    public function getRequestTime()
    {
        return $this->_time;
    }

    /**
     * Return server hostname:port
     *
     * @return String
     */
    public function getServer()
    {
        return $this->_server . ':' . $this->_port;
    }
}