<?php
# Constants
define('MEMCACHE_STATS', 0);
define('MEMCACHE_SLABS', 1);
define('MEMCACHE_DIFF', 2);

# Stats Query Options
define('QUERY_START', 20);
define('QUERY_END', 21);
define('QUERY_COLUMNS', 22);

function __autoload($class)
{
    require_once str_replace('_', DIRECTORY_SEPARATOR, $class) . '.php';
}