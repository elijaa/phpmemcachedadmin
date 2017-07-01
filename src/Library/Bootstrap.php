<?php
# Headers
header('Content-type: text/html;');
header('Cache-Control: no-cache, must-revalidate');

# Constants declaration
define('CURRENT_VERSION', '1.3.0');

# PHP < 5.3 Compatibility
if (defined('ENT_IGNORE') === false) {
    define('ENT_IGNORE', 0);
}


# XSS / User input check
function xss_check($request)
{
    foreach ($request as $index => $data) {
        if (gettype($data) == 'string') {
            $request[$index] = htmlentities($data);
        } elseif (gettype($data) == 'array') {
            $data = xss_check($data);
        }
    }
    return $request;
}
$_REQUEST=xss_check($_REQUEST);

# Autoloader
function __autoload($class)
{
    require_once str_replace('_', DIRECTORY_SEPARATOR, $class) . '.php';
}

# Loading ini file
$_ini = Library_Configuration_Loader::singleton();

# Date timezone
date_default_timezone_set('Europe/Paris');
