<?php
echo sprintf('%30s', 'INSTANCE');
echo sprintf('%7s', '%MEM');
echo sprintf('%7s', '%HIT');
echo sprintf('%7s', '%MISS');
echo sprintf('%6s', 'CONN');
echo sprintf('%9s', 'GET/s');
echo sprintf('%9s', 'SET/s');
echo sprintf('%9s', 'DEL/s');
echo sprintf('%9s', 'EVI/s');
echo sprintf('%9s', 'READ/s');
echo sprintf('%9s', 'WRITE/s');
echo "\r\n";

foreach($stats as $server => $data)
{
    echo sprintf('%30s', $server);
    echo sprintf('%7s', $data['bytes_percent']);
    echo sprintf('%7s', $data['hit_percent']);
    echo sprintf('%7s', $data['miss_percent']);
    echo sprintf('%6s', $data['curr_connections']);
    echo sprintf('%10s', Library_Analysis::valueResize($data['get_rate'] / $time));
    echo sprintf('%9s', Library_Analysis::valueResize($data['set_rate'] / $time));
    echo sprintf('%9s', Library_Analysis::valueResize($data['delete_rate'] / $time));
    echo sprintf('%9s', Library_Analysis::valueResize($data['evictions'] / $time));
    echo sprintf('%8s', trim(substr(Library_Analysis::byteResize($data['bytes_read'] / $time), 0, -6)));
    echo sprintf('%9s', trim(substr(Library_Analysis::byteResize($data['bytes_written'] / $time), 0,-6)));
    echo "\r\n";
}
?>