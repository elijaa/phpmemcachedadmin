<?php

use App\Library\App;

# App.'s hard-coded configuration
const CURRENT_VERSION = '2.0.0';

require __DIR__ .'/../vendor/autoload.php';

ob_start();

# XSS / User input check
foreach ($_REQUEST as $index => $data) {
    $_REQUEST[$index] = htmlentities($data);
}

$app = App::getInstance();
$_ini = $app; // legacy variable

# Date timezone
$timeZone = $app->get('time_zone');
date_default_timezone_set($timeZone);

# Headers
header('Content-type: text/html; charset=utf-8');
header('Cache-Control: no-cache, must-revalidate');
