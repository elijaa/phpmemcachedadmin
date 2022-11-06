<?php

use App\Library\Configuration\Loader;

# Headers
header('Content-type: text/html; charset=utf-8');
header('Cache-Control: no-cache, must-revalidate');

# Constants declaration
const CURRENT_VERSION = '2.0.0';

# PHP < 5.3 Compatibility
if (defined('ENT_IGNORE') === false) {
    define('ENT_IGNORE', 0);
}

require __DIR__ .'/../../vendor/autoload.php';

# XSS / User input check
foreach ($_REQUEST as $index => $data) {
    $_REQUEST[$index] = htmlentities($data);
}

# Loading ini file
$_ini = Loader::singleton();

# Date timezone
date_default_timezone_set('Europe/Paris');
