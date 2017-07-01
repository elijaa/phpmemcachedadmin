<?php

if (getenv('MEMCACHED_GROUPS')) {
    $groups = getenv('MEMCACHED_GROUPS');
    $i = 0;
    $servers = [];
    while ($i < $groups) {
        $group_name = getenv('MEMCACHED_GROUP_' . $i . '_NAME');
        $hosts = getenv('MEMCACHED_GROUP_' . $i . '_HOST_COUNT');
        $j = 0;
        $servers[$group_name] = [];
        while ($j < $hosts) {
            $hostname = getenv('MEMCACHED_GROUP_' . $i . '_HOST_' . $j);
            $port = getenv('MEMCACHED_GROUP_' . $i . '_PORT_' . $j);
            $servers[$group_name][$hostname . ':' . $port] =
        [
          'hostname' => $hostname,
          'port' => $port,
        ];
            $j++;
        }
        $i++;
    }
} else {
    $servers =
    [
      'Default' =>
      [
        '127.0.0.1:11211' =>
        [
          'hostname' => '127.0.0.1',
          'port' => '11211',
        ],
        '127.0.0.2:11211' =>
        [
          'hostname' => '127.0.0.2',
          'port' => '11211',
        ],
      '127.0.0.3:11211' =>
      [
        'hostname' => '127.0.0.1',
        'port' => '11211',
      ],
      '127.0.0.4:11211' =>
      [
        'hostname' => '127.0.0.1',
        'port' => '11211',
      ],
    ],
  ];
}

$array = [
  'stats_api' => 'Server',
  'slabs_api' => 'Server',
  'items_api' => 'Server',
  'get_api' => 'Server',
  'set_api' => 'Server',
  'delete_api' => 'Server',
  'flush_all_api' => 'Server',
  'connection_timeout' => '1',
  'max_item_dump' => '100',
  'refresh_rate' => 5,
  'memory_alert' => '80',
  'hit_rate_alert' => '90',
  'eviction_alert' => '0',
  'file_path' => 'Temp/',
  'servers' => $servers,
];

return $array;
