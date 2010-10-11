    <div class="size-4" style="float:left;margin-top:18px;">
        <div class="sub-header corner padding">Get <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['get_hits']); ?>
                <span class="right">[<?php echo $stats['get_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['get_misses']); ?>
                <span class="right">[<?php echo $stats['get_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['get_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Set <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Total</span>
                <?php echo Library_Analysis::hitResize($stats['cmd_set']); ?>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['set_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Delete <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['delete_hits']); ?>
                <span class="right">[<?php echo $stats['delete_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['delete_misses']); ?>
                <span class="right">[<?php echo $stats['delete_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['delete_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Cas <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['cas_hits']); ?>
                <span class="right">[<?php echo $stats['cas_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['cas_misses']); ?>
                <span class="right">[<?php echo $stats['cas_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Bad Value</span>
                <?php echo Library_Analysis::hitResize($stats['cas_badval']); ?>
                <span class="right">[<?php echo $stats['cas_badval_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['cas_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Increment <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['incr_hits']); ?>
                <span class="right">[<?php echo $stats['incr_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['incr_misses']); ?>
                <span class="right">[<?php echo $stats['incr_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['incr_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Decrement <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['decr_hits']); ?>
                <span class="right">[<?php echo $stats['decr_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['decr_misses']); ?>
                <span class="right">[<?php echo $stats['decr_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['decr_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Flush <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Total</span>
                <?php echo Library_Analysis::hitResize($stats['cmd_flush']); ?>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo $stats['flush_rate']; ?> Request/sec
            </div>
        </div>
    </div>

    <div class="size-2" style="float:left;padding-left:9px;margin-top:18px;">
<?php
# Viewing a server
if(isset($_GET['server']))
{ ?>
        <form method="post" id="flushForm" action="commands.php">
        <div class="header corner padding size-3cols" style="text-align:center;">
            <a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">See Slabs Stats</a> |
            <input type="hidden" name="request_server" value="<?php echo $_GET['server']; ?>"/>
            <input type="hidden" name="request_api" value="<?php echo $_ini->get('flush_all_api'); ?>"/>
            <input type="hidden" name="request_command" value="flush_all"/>
            <a href="#" onclick="flushServer(document.getElementById('flushForm'));">Flush this Server</a>
        </div>
        </form>
        <br/>
<?php
} ?>
        <div class="sub-header corner padding">Server <span class="green">Stats</span></div>
        <div class="container corner padding size-3cols">
            <div class="line">
                <span class="left setting">Uptime</span>
                <?php echo Library_Analysis::uptime($stats['uptime']); ?>
            </div>
            <div class="line">
                <span class="left setting">Memcached</span>
                Version <?php echo $stats['version']; ?>
            </div>
            <div class="line" style="margin-top:4px;">
                <span class="left setting">Curr Connections</span>
                <?php echo $stats['curr_connections']; ?>
            </div>
            <div class="line">
                <span class="left setting">Total Connections</span>
                <?php echo Library_Analysis::hitResize($stats['total_connections']); ?>
            </div>
            <div class="line">
                <span class="left setting">Max Connections Errors</span>
                <?php echo Library_Analysis::hitResize($stats['listen_disabled_num']); ?>
            </div>

            <div class="line" style="margin-top:4px;">
                <span class="left setting">Current Items</span>
                <?php echo Library_Analysis::hitResize($stats['curr_items']); ?>
            </div>
            <div class="line">
                <span class="left setting">Total Items</span>
                <?php echo Library_Analysis::hitResize($stats['total_items']); ?>
            </div>
<?php
# Viewing a single server
if(isset($settings['oldest']))
{ ?>
            <div class="line">
                <span class="left setting">Oldest Item</span>
                <?php echo Library_Analysis::uptime($settings['oldest']); ?>
            </div>
<?php
} ?>
        </div>
        <br/>
        <div class="sub-header corner padding">Eviction <?php if(isset($stats['reclaimed'])) { echo ' &amp; Reclaimed'; } ?> <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left setting">Items Eviction</span>
                <?php echo Library_Analysis::hitResize($stats['evictions']); ?>
            </div>
            <div class="line">
                <span class="left setting">Rate</span>
                <?php echo $stats['eviction_rate']; ?> Eviction/sec
            </div>
<?php
# Memcached version 1.4.5 and above
if(isset($stats['reclaimed']))
{ ?>
            <div class="line">
                <span class="left setting">Reclaimed</span>
                <?php echo Library_Analysis::hitResize($stats['reclaimed']); ?>
            </div>
            <div class="line">
                <span class="left setting">Rate</span>
                <?php echo $stats['reclaimed_rate']; ?> Reclaimed/sec
            </div>
<?php
} ?>
        </div>
        <br/>
<?php
# Viewing a server
if(isset($_GET['server']))
{ ?>
        <div class="sub-header corner padding">Server <span class="green">Configuration</span></div>
        <div class="container corner padding">
<?php
# Not Northscale server
if(isset($stats['accepting_conns']))
{ ?>
            <div class="line">
                <span class="left setting">Accepting Connections</span>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Accepting Connections : This is the crazy little Easy Tooltip Text.</span></a>
                </span>
                <?php if($stats['accepting_conns']) { echo 'Yes'; } else { echo 'No'; } ?>
            </div>
<?php } ?>
            <div class="line">
                <span class="left setting">Max Bytes</span>
                <?php echo Library_Analysis::byteResize($settings['maxbytes']); ?>Bytes
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Maximum number of bytes allows in this cache</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max Connection</span>
                <?php echo $settings['maxconns']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Maximum number of clients allowed</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">TCP/UDP Port</span>
                TCP : <?php echo $settings['tcpport'] . ' | UDP : ' . $settings['udpport']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>TCP &amp; UDP listen port</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Listen Interface</span>
                <?php echo $settings['inter']; ?>
            </div>
            <div class="line">
                <span class="left setting">Verbosity</span>
                <?php echo $settings['verbosity']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>0 = none, 1 = some, 2 = lots</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Evictions</span>
                <?php echo ucfirst($settings['evictions']); ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>When Off, LRU evictions are disabled</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Path to Domain Socket</span>
                <?php echo $settings['domain_socket']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Path to the domain socket (if any)</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Domain Socket Umask</span>
                <?php echo $settings['umask']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Chunk Size</span>
                <?php echo $settings['chunk_size']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Minimum space allocated for key + value + flags</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Chunk Size Growth Factor</span>
                <?php echo $settings['growth_factor']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Domain Socket Umask :<br/>umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max Threads</span>
                <?php echo $settings['num_threads']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Domain Socket Umask :<br/>umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Detail Enabled</span>
                <?php echo ucfirst($settings['detail_enabled']); ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Domain Socket Umask :<br/>umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max IO Ops/Event</span>
                <?php echo $settings['reqs_per_event']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Domain Socket Umask :<br/>umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">CAS Enabled</span>
                <?php echo ucfirst($settings['cas_enabled']); ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>Domain Socket Umask :<br/>umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">TCP Listen Backlog</span>
                <?php echo $settings['tcp_backlog']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">[?]<span>TCP listen backlog :<br/>TCP listen backlog</span></a>
                </span>
            </div>
<?php
# Memcached >= 1.4.4
if(isset($settings['auth_enabled_sasl']))
{ ?>
            <div class="line">
                <span class="left setting">SASL Auth</span>
                <?php echo ucfirst($settings['auth_enabled_sasl']); ?>
            </div>
<?php
} ?>
        </div>
<?php
}
# Viewing all servers
else
{ ?>
        <div class="sub-header corner padding">Servers in Cluster <span class="green">List</span></div>
        <div class="container corner padding">
<?php
foreach(Library_Configuration_Loader::singleton()->get('servers') as $server)
{ ?>
            <div class="line">
                <span class="left setting">Hostname:port</span>
                <?php echo $server['hostname'] . ':' . $server['port']; ?>
            </div>
<?php
} ?>
         </div>

<?php
} ?>
    </div>

    <div class="size-4" style="float:left; padding-left:9px;clear:right;margin-top:18px;">
        <div class="sub-header corner padding">Cache Size <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Used</span>
                <?php echo Library_Analysis::byteResize($stats['bytes']); ?>Bytes
            </div>
            <div class="line">
                <span class="left">Total</span>
                <?php echo Library_Analysis::byteResize($stats['limit_maxbytes']); ?>Bytes
            </div>
         </div>
         <br/>

        <div class="sub-header corner padding">Cache Size <span class="green">Graphic</span></div>
        <div class="container corner padding">
                <img src="http://chart.apis.google.com/chart?cht=pc&amp;chd=t:<?php echo $stats['bytes_percent']; ?>,<?php echo (100 - $stats['bytes_percent']); ?>&amp;chs=270x200&amp;chl=Used|Free&amp;chf=bg,s,f2f2f2&amp;chco=B5463F|2A707B" alt="Cache Size by GoogleChart" width="270" height="200"/>
        </div>
        <br/>

        <div class="sub-header corner padding">Cache Request <span class="green">Stats</span></div>
         <div class="container corner padding">
            <div class="line">
                <span class="left">Request Rate</span>
                <?php echo $stats['request_rate']; ?> Request/sec
            </div>
            <div class="line">
                <span class="left">Hit Rate</span>
                <?php echo $stats['hit_rate']; ?> Request/sec
            </div>
            <div class="line">
                <span class="left">Miss Rate</span>
                <?php echo $stats['miss_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Hit &amp; Miss Rate <span class="green">Graphic</span></div>
         <div class="container corner padding">
            <div class="line">
            <img src="http://chart.apis.google.com/chart?cht=bvg&amp;chd=t:<?php echo $stats['hit_percent']; ?>,<?php echo $stats['miss_percent']; ?>&amp;chs=270x180&amp;chl=Hit|Miss&amp;chf=bg,s,f2f2f2&amp;chco=2A707B|B5463F&amp;chxt=y&amp;chbh=a&amp;chm=N,000000,0,-1,11" alt="Cache Hit &amp; Miss Rate by GoogleChart" width="270" height="180"/>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Network <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Bytes Read</span>
                <?php echo Library_Analysis::byteResize($stats['bytes_read']); ?>Bytes
            </div>
            <div class="line">
                <span class="left">Bytes Written</span>
                <?php echo Library_Analysis::byteResize($stats['bytes_written']); ?>Bytes
            </div>
        </div>
    </div>