<?php

use Symfony\Component\VarDumper\VarDumper;

/**
 * Since native dd() does not send the 500 HTTP status anymore, lets do it ourselves,
 * to make the debugging of AJAX endpoints easier.
 *
 * @param ...$vars
 * @return void
 */
function d(...$vars): void
{
    // clear everything that was output before
    while (ob_get_level()) {
        ob_end_clean();
    }

    // send the HTTP response code
    http_response_code(500);

    // dump the data
    foreach ($vars as $v) {
        VarDumper::dump($v);
    }

    // output the stack trace
    $e = new Exception;
    echo '<pre>';
    print_r($e->getTraceAsString());
    echo '</pre>';

    // stop execution
    die(1);
}
