<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
    <title>phpMemCacheAdmin</title>
    <link rel="stylesheet" type="text/css" href="public/styles/style.css"/>
</head>
<body>
<div style="margin: 0 auto; width:788px; position: relative;">
    <a href="http://memcached.org/"><img src="public/images/banner.jpg" alt="Memcache.org banner" width="785" height="145"/></a>
    <div class="serverlist rounded" style="padding: 3px 7px 3px 7px; width: 772px;">Actually seeing
        <select class="serverlist" onchange="window.location='index.php?server='+this.options[this.selectedIndex].value">
        <option value="all" <?php if(!isset($_GET['server'])) { echo 'selected="selected"'; } ?>>All Servers</option>
<?php
        # Servers
        foreach($_ini['server'] as $server => $port)
        { ?>
		<option value="<?php echo $server; ?>" <?php if((isset($_GET['server'])) && ($_GET['server'] == $server)) { echo 'selected="selected"'; } ?>>
			<?php echo substr($server, 0, 40); ?>
		</option>
<?php   } ?>
        </select>
<?php
        # Viewing a server
        if(isset($_GET['server']))
        {
            if(!isset($_GET['show']) || ($_GET['show'] == 'items'))
            { ?>
             | <a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">See Slabs Stats for this Server</a>
<?php       }
            elseif($_GET['show'] == 'slabs')
            { ?>
             | <a href="?server=<?php echo $_GET['server']; ?>">Back to this Server Stats </a>
<?php       }
        } ?>
     | <a href="?ini_file">Edit Configuration</a>
    </div>