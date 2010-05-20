<script type="text/javascript">
$(function() {
    $("#tabs").tabs({});
});
</script>
<div id="tabs" class="size-1col padding">
    <ul style="border:1px solid #2c2726;background:url('images/ui-bg_highlight-soft_15_b5463f_1x100.png') repeat-x scroll 50% 50% #514845;">
        <li><a href="#get">Get</a></li>
        <li><a href="#set">Set</a></li>
        <li><a href="#delete">Delete</a></li>
        <li><a href="#flush_all">Flush_All</a></li>
    </ul>
    <div id="get">
        <form method="post" action="commands.php">
           <div class="row">
                Execute get command on one or all memcached servers<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands" name="request_key"/></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo Library_HTML::serverList(); ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo Library_HTML::apiList($_ini->get('get_api'), 'request_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="hidden" name="request_command" value="get"/>
                <input type="submit" value="Execute Get"/>
            </div>
        </form>
    </div>

    <div id="delete">
        <form method="post" action="commands.php">
            <div class="row">
                Execute delete command on one or all memcached servers<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands" name="request_key"/></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo Library_HTML::serverList(); ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo Library_HTML::apiList($_ini->get('delete_api'), 'request_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="hidden" name="request_command" value="delete"/>
                <input class="menu serverlist" type="submit" value="Execute Delete"/>
            </div>
        </form>
    </div>
        <!--
        <div class="ui-corner-all ui-widget-content size-2cols padding" style="margin-top:46px;">
            <div class="row">
                For more informations about memcached commands, see memcached protocol
                <a href="http://github.com/memcached/memcached/blob/master/doc/protocol.txt" target="_blank"><span class="green">here</span></a>
            </div>
        </div>
        -->

    <div id="set">
        <form method="post" action="commands.php">
            <div class="row">
                Execute set command on one or all memcached servers<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands" name="request_key"/></div>
            </div>
            <div class="row">
                <div class="left">Duration</div>
                <div><input class="commands" name="request_duration"/></div>
            </div>
            <div class="row">
                <div class="left">Data</div>
                <div><textarea name="request_data" rows="4" cols="5"></textarea></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo Library_HTML::serverList(); ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo Library_HTML::apiList($_ini->get('set_api'), 'request_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="hidden" name="request_command" value="set"/>
                <input type="submit" value="Execute Set"/>
            </div>
        </form>
    </div>

    <div id="flush_all">
        <form method="post" id="flushForm" action="commands.php">
            <div class="row">
                Execute flush_all command on one or all memcached servers<br/>
                Delay in second before flushing is optional<br/>
                <hr/>
            </div>
            <div class="row">
                <div class="left">Delay</div>
                <div><input class="ui-state-default ui-corner-all" name="request_key"/></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo Library_HTML::serverList(); ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo Library_HTML::apiList($_ini->get('flush_all_api'), 'request_api'); ?></div>
            </div>
            <div class="row" style="text-align:center;">
                <hr/>
                <input type="hidden" name="request_command" value="flush_all"/>
                <input type="submit" onclick="return flushServer(document.getElementById('flushForm'))" value="Execute Flush All"/>
            </div>
        </form>
    </div>
    </div>