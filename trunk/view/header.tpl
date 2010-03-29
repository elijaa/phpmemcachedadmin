<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">  
<html>
<head>
    <title>phpMemCacheAdmin</title>
    <link rel="stylesheet" type="text/css" href="public/styles/style.css"/>
</head>
<body>
<div style="margin: 0 auto; width:788px; position: relative;">
    <a href="http://memcached.org/"><img src="public/images/banner.jpg" alt="Memcache.org banner" width="785" height="145"/></a>             
    <div class="serverlist rounded" style="padding: 3px 7px 3px 7px; width: 772px;">Select :
        <?php 
        if(!isset($_GET['server'])) 
        { 
            echo ' [<a href="?">All Servers</a>] &nbsp; ';
        } 
        else 
        {
            echo ' <a href="?">All Servers</a> &nbsp; ';
        }
        foreach($_ini['server'] as $server => $port) 
        { 
            if(isset($_GET['server']) && ($_GET['server'] == $server)) 
            { 
                echo '[<a href="?server=' . $server . '">' . $server . '</a>]  &nbsp; ';
            } 
            else 
            { 
                echo '<a href="?server=' . $server . '">' . $server . '</a> &nbsp; ';
            }
        } ?>
        <hr/>
        Actually seeing 
        <?php
        if(isset($_GET['server'])) 
        { 
            echo $_GET['server'];
        } 
        else
        {
            echo ' all servers';
        } 
        if(isset($_GET['show']))
        {
            if($_GET['show'] == 'slabs')
            {
                echo ' Slabs Stats';
            }
            elseif($_GET['show'] == 'items')
            {
                echo ', Slab ' . $_GET['slab'] . ', first ' . $_ini['max_item_dump'] . ' Items';
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