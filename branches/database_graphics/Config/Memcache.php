<?php
return array (
  'stats_api' => 'Server',
  'slabs_api' => 'Server',
  'items_api' => 'Server',
  'get_api' => 'Server',
  'set_api' => 'Server',
  'delete_api' => 'Server',
  'flush_all_api' => 'Server',
  'connection_timeout' => '3',
  'max_item_dump' => '50',
  'refresh_rate' => '5',
  'memory_alert' => '75',
  'hit_rate_alert' => '80',
  'eviction_alert' => '5',
  'file_path' => 'Temp/',
  'temp_file_path' => '',
  'storage' => 'SQLite',
  'clusters' => 
  array (
    'default_cluster' => 
    array (
      0 => 'localhost:11211',
    ),
  ),
);