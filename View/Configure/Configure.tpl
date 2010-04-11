    <br/>
    <div style="float:left;">
        <span class="title grey rounded" style="width:374px;">Commands <span class="green">Configuration</span></span>
        <div class="container rounded" style="width:374px;padding:7px;">
            <form method="post" action="configure.php?request_write=commands">
            <div class="row">
                Memcached commands API used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                - Use Server for stats, slabs, items<br/>
                - PECL Memcached does not support the slabs and items commands<br/>
                - If you're using PECL Memcached in your scripts, don't use PECL Memcache to set, get or delete<br/>
                - If you're using PECL Memcache in your scripts, don't use PECL Memcached to set, get or delete<br/>
                - PECL Memcache can't use delay with flush_all<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Stats</div>
                <div><?php echo Library_HTML::apiList($_ini['stats_api'], 'stats_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Slabs</div>
                <div><?php echo Library_HTML::apiList($_ini['slabs_api'], 'slabs_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Items</div>
                <div><?php echo Library_HTML::apiList($_ini['items_api'], 'items_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Get</div>
                <div><?php echo Library_HTML::apiList($_ini['get_api'], 'get_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Set</div>
                <div><?php echo Library_HTML::apiList($_ini['set_api'], 'set_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Delete</div>
                <div><?php echo Library_HTML::apiList($_ini['delete_api'], 'delete_api'); ?></div>
            </div>
            <div class="row">
                <div class="left">Flush All</div>
                <div><?php echo Library_HTML::apiList($_ini['flush_all_api'], 'flush_all_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input class="menu serverlist" type="submit" value="Save API Configuration"/>
            </div>
            </form>
        </div>
    </div>

    <div style="float:left; padding-left:10px;">
        <span class="title grey rounded" style="width:374px;">Server <span class="green">List</span></span>
        <div class="container rounded" style="width:374px;padding:7px;">
            <form method="post" action="configure.php?request_write=servers">
            <div class="row">
                Servers list used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                Use the scheme hostname:port even if port is 11211
                <hr/>
            </div>
            <div id="server_form">
            <?php
            foreach($_ini['server'] as $server)
            { ?>
            <div id="server_<?php echo $server; ?>">
                <div class="row">
                    <div class="left">Server</div>
                    <div>
                        <input type="text" name="server[]" value="<?php echo $server; ?>" onfocus="serverOnFocus(this)" onblur="serverOnBlur(this)"/>
                        <a class="menu grey serverlist" style="padding:1px 2px;-moz-border-radius:3px;-webkit-border-radius:3px;" href="#" onclick="deleteServer('server_<?php echo $server; ?>')">Delete</a>
                    </div>
                </div>
            </div>
            <?php
            } ?>
            </div>
            <div class="row">
                <hr/>
                <a class="menu grey serverlist" style="padding:1px 20px;-moz-border-radius:3px;-webkit-border-radius:3px;" href="javascript:addServer()">Add New Server</a>
                <input class="menu serverlist" type="submit" value="Save Servers Configuration"/>
            </div>
            </form>
        </div>
        <br/>
        <span class="title grey rounded" style="width:374px;">Miscellaneous <span class="green">Configuration</span></span>
        <div class="container rounded" style="width:374px;padding:7px;">
            <form method="post" action="configure.php?request_write=miscellaneous">
            <div class="row">
                Miscellaneous configuration used by phpMemCacheAdmin<br/><br/>
                <strong>Recommendations :</strong><br/>
                Don't specify a max items too heavy, use get command instead to see a particular key
                <hr/>
            </div>
            <div class="row">
                <div class="left">Timeout</div>
                <div><input type="text" name="connection_timeout" value="<?php echo $_ini['connection_timeout']; ?>"/></div>
            </div>
            <div class="row">
                <div class="left">Max Items</div>
                <div><input type="text" name="max_item_dump" value="<?php echo $_ini['max_item_dump']; ?>"/></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input class="menu serverlist" type="submit" value="Save API Configuration"/>
            </div>
            </form>
        </div>
    </div>