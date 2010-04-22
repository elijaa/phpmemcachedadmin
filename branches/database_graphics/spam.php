<?php
while(true)
{
    $handle = fsockopen('localhost', 11211, $errno, $errstr, 2);
    for($i = rand(0, 200) ; $i < 300 ; $i++)
    {
        fwrite($handle, 'set ' . md5(microtime(true)) . ' 0 18000 10' . "\r\n");
        fwrite($handle, 'aaaaaaaaaa' . "\r\n");
    }
    sleep(rand(0,10));
}

  