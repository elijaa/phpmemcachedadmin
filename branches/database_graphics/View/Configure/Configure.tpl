<?php
# Finding the right tabs to show
$tabs = 0;
if(isset($_GET['type']))
{
    switch($_GET['type'])
    {
        case 'clusters':
            $tabs = 0;
            break;
        case 'commands':
            $tabs = 1;
            break;
        case 'live_stats':
            $tabs = 2;
            break;
        case 'misc':
            $tabs = 3;
            break;
        default :
            $tabs = 0;
            break;
    }
}
?>


    <script type="text/javascript">
    $(function() {
        $("input:submit").button();
        $(".a_link").button();
        $("#tabs").tabs({ selected: <?php echo $tabs; ?> });
    });
    </script>

<div id="tabs" class="size-1col padding">
    <ul>
        <li><a href="#cluster_servers">Cluster/Servers</a></li>
        <li><a href="#commands">Commands</a></li>
        <li><a href="#live_stats">Live Stats</a></li>
        <li><a href="#misc">Miscellaneous</a></li>
    </ul>
    <div id="cluster_servers">
        <form method="post" action="configure.php?request_write=servers">
            <div class="row">
                Servers list used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                - Use the scheme hostname:port even if port is 11211
                <br/>
                - You can specify multiple instance on different port on same server
                <hr/>
            </div>
            <div id="server_form">
            <?php
            # Adding input for every server
            foreach($_ini->get('server') as $server)
            { ?>
            <div id="server_<?php echo $server; ?>">
                <div class="row">
                    <div class="left">Server</div>
                    <div>
                        <input type="text" name="server[]" value="<?php echo $server; ?>" onfocus="serverOnFocus(this)" onblur="serverOnBlur(this)"/>
                        <a class="a_link" href="#" onclick="deleteServer('server_<?php echo $server; ?>')">Delete</a>
                    </div>
                </div>
            </div>
            <?php
            } ?>
            </div>
            <div class="row">
                <hr/>
                <a class="a_link" href="javascript:addServer()">Add New Server</a>
                <input type="submit" value="Save Servers Configuration"/>
            </div>
            </form>
    </div>
    <div id="commands">
        <form method="post" action="configure.php?request_write=commands">
            <div class="row">
                Memcached commands API used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                - Use Server for stats, slabs, items<br/>
                - PECL Memcached does not support the slabs and items commands<br/>
                - If you're using PECL Memcache in your scripts, don't use PECL Memcache, same thing for PECL Memcached<br/>
                - PECL Memcache can't use delay with flush_all<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Stats</div>
                <div><?php echo Library_HTML::apiList($_ini->get('stats_api'), 'stats_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Slabs</div>
                <div><?php echo Library_HTML::apiList($_ini->get('slabs_api'), 'slabs_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Items</div>
                <div><?php echo Library_HTML::apiList($_ini->get('items_api'), 'items_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Get</div>
                <div><?php echo Library_HTML::apiList($_ini->get('get_api'), 'get_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Set</div>
                <div><?php echo Library_HTML::apiList($_ini->get('set_api'), 'set_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Delete</div>
                <div><?php echo Library_HTML::apiList($_ini->get('delete_api'), 'delete_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Flush All</div>
                <div><?php echo Library_HTML::apiList($_ini->get('flush_all_api'), 'flush_all_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="submit" value="Save API Configuration"/>
            </div>
            </form>
    </div>
    <div id="live_stats">
        <form method="post" action="configure.php?request_write=live_stats">
            <div class="row">
                Configuration for Live Stats<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Refresh Rate</div>
                <div><input type="text" name="refresh_rate" value="<?php echo $_ini->get('refresh_rate'); ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Memory Alert</div>
                <div><input type="text" name="memory_alert" value="<?php echo $_ini->get('memory_alert'); ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Hit Rate Alert</div>
                <div><input type="text" name="hit_rate_alert" value="<?php echo $_ini->get('hit_rate_alert'); ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Eviction Alert</div>
                <div><input type="text" name="eviction_alert" value="<?php echo $_ini->get('eviction_alert'); ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Temp Path</div>
                <div><input type="text" name="file_path" value="<?php echo $_ini->get('file_path'); ?>"/></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="submit" value="Save Live Configuration"/>
            </div>
            </form>
    </div>
    <div id="misc">
        <form method="post" action="configure.php?request_write=miscellaneous">
            <div class="row">
                Miscellaneous configuration used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                - Don't specify a max items too heavy, use get command instead to see a particular key
                <hr/>
            </div>
            <div class="row">
                <div class="left">Timeout</div>
                <div><input type="text" name="connection_timeout" value="<?php echo $_ini->get('connection_timeout'); ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Max Items</div>
                <div><input type="text" name="max_item_dump" value="<?php echo $_ini->get('max_item_dump'); ?>"/></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="submit" value="Save API Configuration"/>
            </div>
            </form>
    </div>
</div>

<!--
<div class="ui-widget-content ui-corner-all full-size padding">
    <div class="row">
        For more information about configuring phpMemCacheAdmin, see installation guide
        <a href="http://code.google.com/p/phpmemcacheadmin/wiki/InstallationGuide" target="_blank"><span class="green">here</span></a>
    </div>
</div>-->
