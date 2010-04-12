<?php
require_once 'Library/Command/Interface.php';
require_once 'Library/Command/Factory.php';
require_once 'Library/Analysis.php';
require_once 'Library/Configuration.php';

# Date timezone
date_default_timezone_set('Europe/Paris');

# Loading ini file
$_ini = Library_Configuration::getInstance();

# Opening stats snapshot @todo handle lack of stats
$snapshot = unserialize(file_get_contents('Snapshot/toto'));

# Taking a new snapshot
$new = array();

foreach($_ini['server'] as $server)
{
        # Spliting server in hostname:port
    $server = preg_split('/:/', $server);
    $new[$server[0] . ':' . $server[1]] = Library_Analysis::stats(Library_Command_Factory::instance('stats_api')->stats($server[0], $server[1]));
}

file_put_contents('Snapshot/toto', serialize($new));

# Requesting stats
$stats = array();
$time = 0;
foreach($_ini['server'] as $server)
{
    $stats[$server] = Library_Analysis::diff($snapshot[$server], $new[$server]);
    $time = $stats[$server]['uptime'];
    foreach($stats as $server => $array)
    {
        $stats[$server] = Library_Analysis::stats($stats[$server]);
        $stats[$server]['bytes_percent'] = $new[$server]['bytes_percent'];
        $stats[$server]['curr_connections'] = $new[$server]['curr_connections'];
    }
}

include 'View/Live/Stats.tpl';