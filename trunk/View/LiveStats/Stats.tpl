<?php
# @TODO : Make this compatible with command line
# Header
print 'Last update : ' . date('r', time()) . ' (refresh rate : ' . $_ini->get('refresh_rate') . ' sec)';
echo "\r\n\r\n<strong>";

# Table header
echo sprintf('%-30s', 'SERVER:PORT'),
sprintf('%7s', '%MEM'),
sprintf('%7s', '%HIT'),
sprintf('%8s', 'TIME'),
sprintf('%8s', 'HIT/s'),
sprintf('%6s', 'CONN'),
sprintf('%8s', 'GET/s'),
sprintf('%8s', 'SET/s'),
sprintf('%8s', 'DEL/s'),
sprintf('%8s', 'EVI/s'),
sprintf('%9s', 'READ/s'),
sprintf('%10s', 'WRITE/s');
echo "</strong>\r\n<hr>";

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
    # Ping
    echo sprintf('%5.0f', Library_Analysis::valueResize($data['query_time'])) . ' ms';
    # Hit rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['hit_rate'] + $data['miss_rate']));
    # Current connection
    echo sprintf('%6s', $data['curr_connections']);
    # Get rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['get_rate']));
    # Set rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['set_rate']));
    # Delete rate
    echo sprintf('%8s', Library_Analysis::valueResize($data['delete_rate']));
    # Eviction rate
    if($data['eviction_rate'] > $_ini->get('eviction_alert'))
    {
        echo str_pad('', 8 - strlen(Library_Analysis::valueResize($data['eviction_rate'])), ' ') . '<span class="alert">' . Library_Analysis::valueResize($data['eviction_rate']) . '</span>';
    }
    else
    {
        echo sprintf('%8s', Library_Analysis::valueResize($data['eviction_rate']));
    }
    # Bytes read
    echo sprintf('%9s', Library_Analysis::byteResize($data['bytes_read'] / $data['time']) . 'b');
    # Bytes written
    echo sprintf('%10s', Library_Analysis::byteResize($data['bytes_written'] / $data['time']) . 'b');
    # End of Line
    echo "\r\n<hr>";
}