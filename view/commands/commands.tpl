<?php
# Making Servers Select
$serverSelect = '<select class="commands"><option value="">All Servers</option>';
foreach($_ini['server'] as $server => $port)
{
    $serverSelect .= '<option value="' . $server . '">' . $server . '</option>';
}
$serverSelect .= '</select>';

# Making API Select
$apiSelect = '<select class="commands"><option value="Server">Server API</option>
<option value="Memcache">Memcache API</option><option value="Memcached">Memcached API</option></select>';
?>
    <br/>
    <div style="float:left;">
        <span class="title rounded" style="width:386px;">Get Command</span>
        <div class="container rounded" style="width:386px; padding:7px 7px 7px 7px;">
            <div class="row"><strong>Execute get command</strong></div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands"></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo $serverSelect; ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo $apiSelect; ?></div>
            </div>
        </div>
        <br/>
        <span class="title rounded" style="width:386px;">Get Command</span>
        <div class="container rounded" style="width:386px; padding:7px 7px 7px 7px;">
            <div class="row"><strong>Execute get command</strong></div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands"></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo $serverSelect; ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo $apiSelect; ?></div>
            </div>
        </div>
    </div>

    <div style="float:left; padding-left:10px;">
        <br/>
        <span class="title rounded" style="width:386px;">Set Command</span>
        <div class="container rounded" style="width:386px; padding:7px 7px 7px 7px;">
            <div class="row"><strong>Execute set command</strong></div>
            <div class="row">
                <div class="left">Key</div>
                <div><input class="commands"></div>
            </div>
            <div class="row">
                <div class="left">Data</div>
                <div><textarea></textarea></div>
            </div>
            <div class="row">
                <div class="left">Server</div>
                <div><?php echo $serverSelect; ?></div>
            </div>
            <div class="row">
                <div class="left">API</div>
                <div><?php echo $apiSelect; ?></div>
            </div>
        </div>
    </div>