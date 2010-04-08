<?php
# Making Servers Select
$serverSelect = '<select class="commands" name="request_server"><option value="">All Servers</option>';
foreach($_ini['server'] as $server => $port)
{
    $serverSelect .= '<option value="' . $server . '">' . $server . '</option>';
}
$serverSelect .= '</select>';

# Making API Select
$apiSelect = '
<select class="commands" name="request_api">
    <option value="Server">Server API</option>
    <option value="Memcache">Memcache API</option>
    <option value="Memcached">Memcached API</option>
</select>';
?>
    <br/>
    <div style="float:left;">
        <span class="title rounded" style="width:374px;">Get <span class="stats">Command</span></span>
        <div class="container rounded" style="width:374px; padding:7px 7px 7px 7px;">
            <form method="get" action="commands.php">
                <div class="row">
                    <div class="left">Key</div>
                    <div><input class="commands" name="request_key"/></div>
                </div>
                <div class="row">
                    <div class="left">Server</div>
                    <div><?php echo $serverSelect; ?></div>
                </div>
                <div class="row">
                    <div class="left">API</div>
                    <div><?php echo $apiSelect; ?></div>
                </div>
                <div class="row" style="text-align:center;">
                    <input type="hidden" name="request_command" value="get"/>
                    <input class="menu serverlist" type="submit" value="Execute Get"/>
                </div>
            </form>
        </div>
        <br/>
        <span class="title rounded" style="width:374px;">Delete <span class="stats">Command</span></span>
        <div class="container rounded" style="width:374px; padding:7px 7px 7px 7px;">
            <form method="get" action="commands.php">
                <div class="row">
                    <div class="left">Key</div>
                    <div><input class="commands" name="request_key"/></div>
                </div>
                <div class="row">
                    <div class="left">Server</div>
                    <div><?php echo $serverSelect; ?></div>
                </div>
                <div class="row">
                    <div class="left">API</div>
                    <div><?php echo $apiSelect; ?></div>
                </div>
                <div class="row" style="text-align:center;">
                    <input type="hidden" name="request_command" value="delete"/>
                    <input class="menu serverlist" type="submit" value="Execute Delete"/>
                </div>
            </form>
        </div>
    </div>

    <div style="float:left; padding-left:10px;">
        <span class="title rounded" style="width:374px;">Set <span class="stats">Command</span></span>
        <div class="container rounded" style="width:374px; padding:7px 7px 7px 7px;">
            <form method="get" action="commands.php">
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
                    <div><textarea name="request_data" rows="5" cols="5"></textarea></div>
                </div>
                <div class="row">
                    <div class="left">Server</div>
                    <div><?php echo $serverSelect; ?></div>
                </div>
                <div class="row">
                    <div class="left">API</div>
                    <div><?php echo $apiSelect; ?></div>
                </div>
                <div class="row" style="text-align:center;">
                    <input type="hidden" name="request_command" value="set"/>
                    <input class="menu serverlist" type="submit" value="Execute Set"/>
                </div>
            </form>
        </div>
    </div>