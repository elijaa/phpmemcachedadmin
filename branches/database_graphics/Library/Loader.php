<?php
# Stats type (Server stats, slabs stats)
define('MEMCACHE_STATS', 0);
define('MEMCACHE_SLABS', 1);

# Diff for stats
define('STATS_DIFF', 2);

# Type of stats requested
define('STATS_TYPE', 3);

# Stats Query Options
define('QUERY_START', 20);
define('QUERY_END', 21);
define('QUERY_COLUMNS', 22);

function __autoload($class)
{
    require_once str_replace('_', DIRECTORY_SEPARATOR, $class) . '.php';
}