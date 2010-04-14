<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>phpMemCacheAdmin</title>
    <link rel="stylesheet" type="text/css" href="Public/Styles/Style.css"/>
    <script type="text/javascript" src="Public/Scripts/Script.js"></script>
</head>
<body>
<div style="margin: 0 auto;width:800px;">
    <div style="margin: 0 auto;width:788px;clear:both;float:left;">

        <div style="margin:-4px 0px 6px 6px;font-weight:bold;font-size:1.2em;">phpMemCacheAdmin</div>
        <div class="serverlist rounded" style="padding:3px 7px 3px 7px;width:772px;">
<?php
# Live Stats view
if(basename($_SERVER['PHP_SELF']) == 'stats.php')
{ ?>
        Live Stats |
<?php
}
else
{ ?>
        <a href="stats.php">See Live Stats </a> |
<?php
}
# Stats view
if(basename($_SERVER['PHP_SELF']) == 'index.php')
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
foreach($_ini->get('server') as $server)
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
if(basename($_SERVER['PHP_SELF']) == 'commands.php')
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
if(basename($_SERVER['PHP_SELF']) == 'configure.php')
{ ?>
        Editing Configuration
<?php
}
else
{ ?>
        <a href="configure.php">Edit Configuration</a>
<?php
} ?>
    </div>

<!--[if IE]>
<br/>
<div class="serverlist rounded" style="text-align:center;padding:3px 7px;width:772px;">
Support browsers that contribute to open source, try <a href="http://www.firefox.com" target="_blank">Firefox</a> or <a href="http://www.google.com/chrome" target="_blank">Google Chrome</a>.
</div>
<![endif]-->
