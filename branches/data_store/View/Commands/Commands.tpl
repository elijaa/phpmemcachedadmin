    <br/>
    <div style="float:left;">
        <span class="title grey rounded" style="width:393px;">Get <span class="green">Command</span></span>
        <div class="container rounded" style="width:393px;padding:7px">
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
                    <input class="menu serverlist" type="submit" value="Execute Get"/>
                </div>
            </form>
        </div>
        <br/>
        <span class="title grey rounded" style="width:393px;">Delete <span class="green">Command</span></span>
        <div class="container rounded" style="width:393px;padding:7px;">
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
        <div class="container rounded" style="width:393px;padding:7px;margin-top:46px;">
            <div class="row">
                For more informations about memcached commands, see memcached protocol
                <a href="http://github.com/memcached/memcached/blob/master/doc/protocol.txt" target="_blank"><span class="green">here</span></a>
            </div>
        </div>
    </div>

    <div style="float:left; padding-left:10px;">
        <span class="title grey rounded" style="width:393px;">Set <span class="green">Command</span></span>
        <div class="container rounded" style="width:393px;padding:7px;">
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
                    <input class="menu serverlist" type="submit" value="Execute Set"/>
                </div>
            </form>
        </div>

        <br/>
        <span class="title grey rounded" style="width:393px;">Flush Server <span class="green">Command</span></span>
        <div class="container rounded" style="width:393px;padding:7px;">
            <form method="post" action="commands.php">
                <div class="row">
                    Execute flush_all command on one or all memcached servers<br/>
                    Delay in second before flushing is optional<br/>
                    <hr/>
                </div>
                <div class="row">
                    <div class="left">Delay</div>
                    <div><input class="commands" name="request_key"/></div>
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
                    <input class="menu serverlist" type="submit" value="Execute Flush All"/>
                </div>
            </form>
        </div>
    </div>