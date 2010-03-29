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
        <select class="serverlist">
        <option value="" <?php if(!isset($_GET['server'])) { echo 'selected="selected"'; } ?>>All Servers</option>
        <?php 
        foreach($_ini['server'] as $server => $port)
        {
        ?>
		<option value="<?php echo $server; ?>" <?php if((isset($_GET['server'])) && ($_GET['server'] == $server)) { echo 'selected="selected"'; } ?>>
			<?php echo $server; ?>
		</option>
        <?php 
        }
        ?>
        </select>
        <?php
        if(isset($_GET['show']))
        {
            if($_GET['show'] == 'slabs')
            {
			?>
        Slabs Stats
			<?php
            }
            elseif($_GET['show'] == 'items')
            {
            ?>
        Slab <?php echo $_GET['slab']; ?>, first <?php echo $_ini['max_item_dump']; ?> Items';
            <?php
            }
        }
        if(isset($_GET['server']))
        {
            if(!isset($_GET['show']))
            {
                echo ' | <a href="?server=' . $_GET['server'] . '&amp;show=slabs">See Slabs Stats for ' . $_GET['server'] . '</a>';
            } 
            elseif($_GET['show'] == 'slabs')
            {
                echo ' | <a href="?server=' . $_GET['server'] . '">Back to ' . $_GET['server'] . ' Server Stats </a>';
            }
            elseif($_GET['show'] == 'items')
            {
                echo ' | <a href="?server=' . $_GET['server'] . '&amp;show=slabs">Back to ' . $_GET['server'] . ' Server Slabs Stats </a>';
            }
        }?>
    </div>