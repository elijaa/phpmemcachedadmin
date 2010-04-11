<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
    <title>phpMemCacheAdmin</title>
    <link rel="stylesheet" type="text/css" href="Public/Styles/Style.css"/>
    <script type="text/javascript" src="Public/Scripts/Script.js"></script>
</head>
<body>
<div style="margin: 0 auto;width:800px;">
    <div style="margin: 0 auto;width:788px;clear:both;float:left;">
        <a href="http://memcached.org/"><img src="Public/Images/Banner.jpg" alt="Memcache.org banner" width="785" height="145"/></a>

        <div class="serverlist rounded" style="padding:3px 7px 3px 7px; width:772px;">
<?php
# Stats view
if ($_SERVER['PHP_SELF'] == '/index.php')
{ ?>
        Actually seeing
<?php
}
else
{ ?>
        <a href="index.php">See Stats for </a>
<?php
} ?>
        <select class="serverlist menu" onchange="changeServer(this)">
        <option value="" <?php if(!isset($_GET['server']) || ($_GET['server'] == '')) { echo 'selected="selected"'; } ?>>All Servers</option>
<?php
# Servers
foreach($_ini['server'] as $server)
{ ?>
        <option value="<?php echo $server; ?>" <?php if((isset($_GET['server'])) && ($_GET['server'] == $server)) { echo 'selected="selected"'; } ?>>
            <?php echo $server; ?>
        </option>
<?php
} ?>
        </select>
        |
<?php
# Commands view
if($_SERVER['PHP_SELF'] == '/commands.php')
{ ?>
        Executing Commands on Servers
<?php
}
else
{ ?>
        <a href="commands.php">Execute Commands on Servers</a>
<?php
}?>
        |
<?php
# Configure view
if($_SERVER['PHP_SELF'] == '/configure.php')
{ ?>
        Editing Configuration File
<?php
}
else
{ ?>
        <a href="configure.php">Edit Configuration</a>
<?php
} ?>
    </div>