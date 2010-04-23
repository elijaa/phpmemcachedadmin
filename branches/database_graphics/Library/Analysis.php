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
 * Analysis of memcached command response
 *
 * @author c.mahieux@of2m.fr
 * @since 20/03/2010
 */
class Library_Analysis
{
    /**
     * Merge two arrays of stats from MemCacheAdmin_ServerCommands::stats()
     *
     * @param $array Statistic from MemCacheAdmin_ServerCommands::stats()
     * @param $stats Statistic from MemCacheAdmin_ServerCommands::stats()
     *
     * @return Array
     */
    public static function merge($array, $stats)
    {
        # Checking input
        if(!is_array($array))
        {
            return $stats;
        }
        elseif(!is_array($stats))
        {
            return $array;
        }

        # Merging Stats
        foreach($stats as $key => $value)
        {
            if(isset($array[$key]) && ($key != 'version'))
            {
                $array[$key] += $value;
            }
            else
            {
                $array[$key] = $value;
            }
        }
        return $array;
    }

    /**
     * Diff two arrays of stats from MemCacheAdmin_ServerCommands::stats()
     *
     * @param Array $array Statistic from MemCacheAdmin_ServerCommands::stats()
     * @param Array $stats Statistic from MemCacheAdmin_ServerCommands::stats()
     *
     * @return Array
     */
    public static function diff($array, $stats)
    {
        # Checking input
        if(!is_array($array))
        {
            return $stats;
        }
        elseif(!is_array($stats))
        {
            return $array;
        }

        # Diff for each key
        foreach($stats as $key => $value)
        {
            if(isset($array[$key]))
            {
                $stats[$key] = $value - $array[$key];
            }
        }
        return $stats;
    }

    /**
     * Analyse and return memcache slabs command
     *
     * @param Array $slabs Statistic from MemCacheAdmin_ServerCommands::slabs()
     *
     * @return Array
     */
    public static function slabs($slabs)
    {
        # Initializing Used Slabs
        $slabs['used_slabs'] = 0;
        $slabs['total_wasted'] = 0;
        # Request Rate par Slabs
        foreach($slabs as $id => $slab)
        {
            # Check if it's a Slab
            if(is_numeric($id))
            {
                # Check if Slab is used
                if($slab['used_chunks'] > 0)
                {
                    $slabs['used_slabs']++;
                }
                $slabs[$id]['request_rate'] = number_format(($slab['get_hits'] + $slab['cmd_set'] + $slab['delete_hits'] + $slab['cas_hits'] + $slab['cas_badval'] + $slab['incr_hits'] + $slab['decr_hits']) / $slabs['uptime'], 1);
                $slabs[$id]['mem_wasted'] = (($slab['total_chunks'] * $slab['chunk_size']) < $slab['mem_requested']) ?(($slab['total_chunks'] -  $slab['used_chunks']) * $slab['chunk_size']):(($slab['total_chunks'] * $slab['chunk_size']) - $slab['mem_requested']);
                $slabs['total_wasted'] += $slabs[$id]['mem_wasted'];
            }
        }
        return $slabs;
    }

    /**
     * Calculate Uptime
     *
     * @param Integer $uptime Uptime timestamp
     *
     * @return String
     */
    public static function uptime($uptime)
    {
        if($uptime > 0)
        {
            $days = floor($uptime / 60 / 60 / 24);
            $hours = $uptime / 60 / 60 % 24;
            $mins = $uptime / 60 % 60;
            if(($days + $hours + $mins) == 0)
            {
                return ' less than 1 min';
            }
            return $days . ' days ' . $hours . ' hrs ' . $mins . ' min';
        }
        return ' - ';
    }

    /**
     * Resize a byte value
     *
     * @param Integer $value Value to resize
     *
     * @return String
     */
    public static function byteResize($value)
    {
        # Unit list
        $units = array('', 'K', 'M', 'G', 'T');

        # Resizing
        foreach($units as $unit)
        {
            if($value < 1024)
            {
                break;
            }
            $value /= 1024;
        }
        return sprintf('%.1f %s', $value, $unit);
    }

    /**
     * Resize a value
     *
     * @param Integer $value Value to resize
     *
     * @return String
     */
    public static function valueResize($value)
    {
        # Unit list
        $units = array('', 'K', 'M', 'G', 'T');

        # Resizing
        foreach($units as $unit)
        {
            if($value < 1000)
            {
                break;
            }
            $value /= 1000;
        }
        return sprintf('%.1f%s', $value, $unit);
    }

    /**
     * Resize a hit value
     *
     * @param Integer $value Hit value to resize
     *
     * @return String
     */
    public static function hitResize($value)
    {
        # Unit list
        $units = array('', 'K', 'M', 'G', 'T');

        # Resizing
        foreach($units as $unit)
        {
            if($value < 10000000)
            {
                break;
            }
            $value /= 1000;
        }
        return sprintf('%.0f%s', $value, $unit);
    }
}