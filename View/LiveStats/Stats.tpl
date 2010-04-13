<?php
# Header
echo 'Last update : ' . date('r', time()) . '   (refresh rate : ' . $_ini->get('refresh_rate') . ' sec)';
echo "\r\n\r\n<strong>";

# Table header
echo sprintf('%-30s', 'SERVER:PORT');
echo sprintf('%7s', '%MEM');
echo sprintf('%7s', '%HIT');
echo sprintf('%7s', 'HIT/s');
echo sprintf('%6s', 'CONN');
echo sprintf('%8s', 'GET/s');
echo sprintf('%8s', 'SET/s');
echo sprintf('%8s', 'DEL/s');
echo sprintf('%9s', 'EVI/s');
echo sprintf('%10s', 'READ/s');
echo sprintf('%10s', 'WRITE/s');
echo "</strong>\r\n";
echo '<hr>';

# Showing stats for every server
foreach($stats as $server => $data)
{
    # Server name
    echo sprintf('%-30.30s', $server);

    # Memory Occupation
    if($data['bytes_percent'] > $_ini->get('memory_alert'))
    {
        echo str_pad('', 7 - strlen($data['bytes_percent']), ' ') . '<span class="alert">' . sprintf('%.1f', $data['bytes_percent']) . '</span>';
    }
    else
    {
        echo sprintf('%7.1f', $data['bytes_percent']);
    }

    # Hit percent (get, set, delete, cas, incr & decr)
    if($data['hit_percent'] < $_ini->get('hit_rate_alert'))
    {
        echo str_pad('', 7 - strlen($data['hit_percent']), ' ') . '<span class="alert">' . sprintf('%.1f', $data['hit_percent']) . '</span>';
    }
    else
    {
        echo sprintf('%7.1f', $data['hit_percent']);
    }

    # Hit rate
    echo sprintf('%7s', Library_Analysis::valueResize($data['hit_rate'] / $time));

    # Current connection
    echo sprintf('%6s', $data['curr_connections']);

    # Get rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['get_rate'] / $time));

    # Set rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['set_rate'] / $time));

    # Delete rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['delete_rate'] / $time));

    # Evication rate
    if($data['evictions'] > $_ini->get('eviction_alert'))
    {
        echo str_pad('', 9 - strlen(Library_Analysis::valueResize($data['evictions'] / $time)), ' ') .
         '<span class="alert">' . Library_Analysis::valueResize($data['evictions'] / $time) . '</span>';
    }
    else
    {
        echo sprintf('%9s', Library_Analysis::valueResize($data['evictions']));
    }

    # Bytes read
    echo sprintf('%10s', Library_Analysis::byteResize($data['bytes_read'] / $time) . 'b');

    # Bytes written
    echo sprintf('%10s', Library_Analysis::byteResize($data['bytes_written'] / $time) . 'b');

    # End of Line
    echo "\r\n";
    echo '<hr>';
}