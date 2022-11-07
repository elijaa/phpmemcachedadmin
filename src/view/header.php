<?php
use App\Library\App;
use App\Library\Html\Components;

echo '<?xml version="1.0" encoding="UTF-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>PHPMemcachedAdmin <?php echo CURRENT_VERSION; ?></title>
    <link rel="stylesheet" type="text/css" href="/styles/style.css"/>
    <script type="text/javascript" src="/scripts/highcharts/highcharts.js"></script>
    <script type="text/javascript" src="/scripts/script.js"></script>
</head>
<body>
<div style="margin:0pt auto; width:1000px; clear:both;">
    <div style="font-weight:bold;font-size:1.2em;"><a href="/" style="color: #000;">PHPMemcachedAdmin</a> <sup><?php echo CURRENT_VERSION; ?></sup></div>

    <div class="header corner full-size padding" style="margin-top:5px;">
        <a href="/">See Stats</a> | <a href="/stats">See Live Stats</a> | <a href="/commands">Execute Commands</a> | <a href="/configure">Edit Configuration</a> | <a href="/data">data</a>
    </div>

    <?php if (!App::getInstance()->isTempDirExists()) { ?>
        <?php exit('<div class="header corner full-size padding" style="margin-top:10px;">Error: Temporary directory <em>"'. App::getInstance()->tempDirPath() .'"</em> does not exist.</div>'); ?>
    <?php } elseif (!App::getInstance()->isTempDirWritable()) { ?>
        <?php exit('<div class="header corner full-size padding" style="margin-top:10px;">Error: Temporary directory <em>"'. App::getInstance()->tempDirPath() .'"</em> is not writable.</div>'); ?>
    <?php } ?>

    <?php if (!App::getInstance()->exists()) { ?>
        <?php exit('<div class="header corner full-size padding" style="margin-top:10px;">Error: Configuration file <em>"'. App::getInstance()->configFilePath() .'"</em> is missing.</div>'); ?>
    <?php } elseif (!App::getInstance()->isWritable()) { ?>
        <?php exit('<div class="header corner full-size padding" style="margin-top:10px;">Error: Configuration file <em>"'. App::getInstance()->configFilePath() .'"</em> is not writable.</div>'); ?>
    <?php } ?>

<!--[if IE]>
    <div class="header corner full-size padding" style="text-align:center;margin-top:10px;">
    Support browsers that contribute to open source, try <a href="https://www.firefox.com" target="_blank">Firefox</a> or <a href="https://www.google.com/chrome" target="_blank">Google Chrome</a>.
    </div>
<![endif]-->
