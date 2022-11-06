<?php

return array_merge(
    [
        'stats_api' => 'Server',
        'slabs_api' => 'Server',
        'items_api' => 'Server',
        'get_api' => 'Server',
        'set_api' => 'Server',
        'delete_api' => 'Server',
        'flush_all_api' => 'Server',
        'connection_timeout' => '1',
        'max_item_dump' => '100',
        'refresh_rate' => 2,
        'memory_alert' => '80',
        'hit_rate_alert' => '90',
        'eviction_alert' => '0',
        'file_path' => 'Temp/',
        'servers' => [
            'Default' => [
                '127.0.0.1:11211' => [
                    'hostname' => '127.0.0.1',
                    'port' => '11211',
                ],
            ],
        ],
    ],
    require('./.config.php')
);
