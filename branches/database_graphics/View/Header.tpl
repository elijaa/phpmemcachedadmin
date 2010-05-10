<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>phpMemCacheAdmin</title>
    <link rel="stylesheet" type="text/css" href="Public/Styles/Style.css"/>
    <link rel="stylesheet" type="text/css" href="Public/Styles/jquery-ui-1.8.1.custom.css"/>
    <script type="text/javascript" src="Public/Scripts/Script.js"></script>
    <script type="text/javascript" src="Public/Scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="Public/Scripts/jquery-ui-1.8.1.custom.min.js"></script>
    <script type="text/javascript" src="Public/Scripts/jquery.flot.min.js"></script>
    <script type="text/javascript" src="Public/Scripts/jquery.flot.crosshair.min.js"></script>
    <script type="text/javascript" src="Public/Scripts/jquery.flot.stack.min.js"></script>
</head>
<body>
    <div style="margin: 0 auto;width:1000px;clear:both;">
        <div style="margin:-4px 0px 6px 6px;font-weight:bold;font-size:1.2em;">phpMemCacheAdmin <sup>1.2.0</sup></div>
        <div class="ui-corner-all ui-widget-header full-size" style="padding:3px 7px 3px 7px;text-align:center;">
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
        <select class="ui-state-default ui-corner-all" onchange="changeServer(this)">
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
<div class="serverlist rounded" style="text-align:center;padding:3px 7px;width:800px;">
Support browsers that contribute to open source, try <a href="http://www.firefox.com" target="_blank">Firefox</a> or <a href="http://www.google.com/chrome" target="_blank">Google Chrome</a>.
</div>
<![endif]-->

<div style="float:left">
<?php
# Stats view
if(basename($_SERVER['PHP_SELF']) == 'stats.php')
{ ?>
    <div style="margin-right:10px;margin-top:16px;" class="menu rounded alert">
        <a href="graphics.php">Live Stats</a>
    </div>
<?php
}
else
{ ?>
    <div style="margin-right:10px;margin-top:16px;" class="menu rounded">
        <a href="graphics.php">Live Stats</a>
    </div>
<?php
}

# Stats view
if(basename($_SERVER['PHP_SELF']) == 'graphics.php')
{ ?>
    <div style="margin-right:10px;margin-top: 10px;" class="ui-corner-all ui-widget-header">
        <a href="graphics.php">Graphics Stats</a>
    </div>
    <div class="menu_items rounded">
        &rsaquo; <a href="graphics.php?stats=hit_rate">Cache Hit &amp; Miss</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=request_seconds">Requests/Seconds</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=network_traffic">Network Traffic</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=memory_usage">Memory Usage</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=current_connections">Current Connections</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=eviction_rate">Eviction Rate</a>
        <br/>
        &rsaquo; <a href="graphics.php?stats=items_cached">Items Cached</a>
    </div>
<?php
}
else
{
?>
   <div style="margin-right:10px;margin-top: 10px;" class="ui-corner-all ui-widget-header padding">
        <a href="graphics.php">Graphics Stats</a>
   </div>
<?php
}

# Servers
if(basename($_SERVER['PHP_SELF']) == 'index.php')
{ ?>
   <div style="margin-right:10px;margin-top:10px;" class="ui-state-active ui-corner-all ui-widget-header padding">
        <a href="index.php">Server Stats</a>
   </div>
<?php
}
else
{
?>
   <div style="margin-right:10px;margin-top: 10px;" class="menu rounded">
        <a href="index.php">Server Stats</a>
   </div>
<?php
}

# Commands view
if(basename($_SERVER['PHP_SELF']) == 'commands.php')
{ ?>
   <div style="margin-right:10px;margin-top: 10px;" class="menu rounded alert">
        <a href="commands.php">Execute Commands</a>
   </div>
<?php
}
else
{
?>
   <div style="margin-right:10px;margin-top: 10px;" class="menu rounded">
        <a href="commands.php">Execute Commands</a>
   </div>
<?php
}

# Configure view
if(basename($_SERVER['PHP_SELF']) == 'configure.php')
{ ?>
    <div style="margin-right:10px;margin-top: 10px;" class="menu rounded alert">
        <a href="configure.php">Configuration</a>
    </div>
    <div class="menu_items rounded">
        &rsaquo; <a href="#">Edit Servers List</a>
        <br/>
        &rsaquo; <a href="#">Edit Commands API</a>
        <br/>
        &rsaquo; <a href="#">Edit Live Stats</a>
    </div>
<?php
}
else
{
?>
   <div style="margin-right:10px;margin-top: 10px;" class="menu rounded">
        <a href="configure.php">Configuration</a>
   </div>
<?php
}
?>
</div>
<div style="float:left;">