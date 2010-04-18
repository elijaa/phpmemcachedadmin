<?php

function __autoload($class)
{
    require_once str_replace('_', DIRECTORY_SEPARATOR, $class) . '.php';
}