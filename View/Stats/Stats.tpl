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
                <?php echo (isset($stats['delete_hits'])) ? Library_Analysis::hitResize($stats['delete_hits']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['delete_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo (isset($stats['delete_misses'])) ? Library_Analysis::hitResize($stats['delete_misses']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['delete_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo (isset($stats['delete_hits'])) ? $stats['delete_rate'] . ' Request/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Cas <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo (isset($stats['cas_hits'])) ? Library_Analysis::hitResize($stats['cas_hits']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['cas_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo (isset($stats['cas_misses'])) ? Library_Analysis::hitResize($stats['cas_misses']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['cas_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Bad Value</span>
                <?php echo (isset($stats['cas_badval'])) ? Library_Analysis::hitResize($stats['cas_badval']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['cas_badval_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo (isset($stats['cas_hits'])) ? $stats['cas_rate'] . ' Request/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Increment <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo (isset($stats['incr_hits'])) ? Library_Analysis::hitResize($stats['incr_hits']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['incr_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo (isset($stats['incr_misses'])) ? Library_Analysis::hitResize($stats['incr_misses']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['incr_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo (isset($stats['incr_hits'])) ? $stats['incr_rate'] . ' Request/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Decrement <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Hits</span>
                <?php echo (isset($stats['decr_hits'])) ? Library_Analysis::hitResize($stats['decr_hits']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['decr_hits_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Miss</span>
                <?php echo (isset($stats['decr_misses'])) ? Library_Analysis::hitResize($stats['decr_misses']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">[<?php echo $stats['decr_misses_percent']; ?>%]</span>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo (isset($stats['decr_hits'])) ? $stats['decr_rate'] . ' Request/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Flush <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Total</span>
                <?php echo (isset($stats['cmd_flush'])) ? Library_Analysis::hitResize($stats['cmd_flush']) : 'N/A on ' . $stats['version']; ?>
            </div>
            <div class="line">
                <span class="left">Rate</span>
                <?php echo (isset($stats['cmd_flush'])) ? $stats['flush_rate'] . ' Request/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
    </div>

    <div class="size-2" style="float:left;padding-left:9px;margin-top:18px;">
<?php
# Viewing a single server
if((isset($_GET['server'])) && ($_ini->server($_GET['server'])))
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
<?php
# Viewing a single server
if((isset($_GET['server'])) && ($_ini->server($_GET['server'])))
{ ?>
            <div class="line">
                <span class="left setting">Uptime</span>
                <?php echo Library_Analysis::uptime($stats['uptime']); ?>
            </div>
            <div class="line">
                <span class="left setting">Memcached</span>
                Version <?php echo $stats['version']; ?>
            </div>
<?php
} ?>
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
                <?php echo (isset($stats['listen_disabled_num'])) ? Library_Analysis::hitResize($stats['listen_disabled_num']) : 'N/A on ' . $stats['version']; ?>
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
if((isset($_GET['server'])) && ($_ini->server($_GET['server'])))
{ ?>
            <div class="line">
                <span class="left setting">Oldest Item</span>
                <?php echo (isset($settings['oldest'])) ? Library_Analysis::uptime($settings['oldest']) : 'N/A on ' . $stats['version']; ?>
            </div>
<?php
} ?>
        </div>
        <br/>
        <div class="sub-header corner padding">Eviction &amp; Reclaimed <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left setting">Items Eviction</span>
                <?php echo Library_Analysis::hitResize($stats['evictions']); ?>
            </div>
            <div class="line">
                <span class="left setting">Rate</span>
                <?php echo $stats['eviction_rate']; ?> Eviction/sec
            </div>
            <div class="line" style="margin-top:4px;">
                <span class="left setting">Reclaimed</span>
                <?php echo (isset($stats['reclaimed'])) ? Library_Analysis::hitResize($stats['reclaimed']) : 'N/A on ' . $stats['version']; ?>
            </div>
            <div class="line">
                <span class="left setting">Rate</span>
                <?php echo (isset($stats['reclaimed'])) ? $stats['reclaimed_rate'] . ' Reclaimed/sec' : 'N/A on ' . $stats['version']; ?>
            </div>
        </div>
        <br/>
<?php
# Viewing a server
if((isset($_GET['server'])) && ($_ini->server($_GET['server'])))
{ ?>
        <div class="sub-header corner padding">Server <span class="green">Configuration</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left setting">Accepting Connections</span>
                <?php
                # Northscale/Membase server specific
                if(isset($stats['accepting_conns']))
                {
                    if($stats['accepting_conns']) { echo 'Yes'; } else { echo 'No'; }
                }
                else
                {
                    echo 'N/A on ' . $stats['version'];
                }?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : accepting_conns<br/>Whether the server is accepting connection or not</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max Bytes</span>
                <?php echo (isset($settings['maxbytes'])) ? Library_Analysis::byteResize($settings['maxbytes']) . 'Bytes' : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : maxbytes<br/>Maximum number of bytes allowed in this cache</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max Connection</span>
                <?php echo (isset($settings['maxconns'])) ? $settings['maxconns'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : maxconns<br/>Maximum number of clients allowed</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">TCP/UDP Port</span>
                <?php echo (isset($settings['tcpport'], $settings['udpport'])) ? 'TCP : ' . $settings['tcpport'] . ', UDP : ' . $settings['udpport'] : 'N/A on ' . $stats['version'] ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : tcpport & udpport<br/>TCP &amp; UDP listen port</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Listen Interface</span>
                <?php echo (isset($settings['inter'])) ? $settings['inter'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : inter<br/>Listen interface</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Evictions</span>
                <?php echo (isset($settings['evictions'])) ? ucfirst($settings['evictions']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : evictions<br/>When Off, LRU evictions are disabled</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Path to Domain Socket</span>
                <?php echo (isset($settings['domain_socket'])) ? $settings['domain_socket'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : domain_socket<br/>Path to the domain socket (if any)</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Domain Socket Umask</span>
                <?php echo (isset($settings['umask'])) ? $settings['umask'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : umask<br/>Umask for the creation of the domain socket</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Chunk Size</span>
                <?php echo (isset($settings['chunk_size'])) ? $settings['chunk_size'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : chunk_size<br/>Minimum space allocated for key + value + flags</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Chunk Growth Factor</span>
                <?php echo (isset($settings['growth_factor'])) ? $settings['growth_factor'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : growth_factor<br/>Chunk size growth factor</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max Threads</span>
                <?php echo (isset($settings['num_threads'])) ? $settings['num_threads'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : num_threads<br/>Number of threads (including dispatch)</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Detail Enabled</span>
                <?php echo (isset($settings['detail_enabled'])) ? ucfirst($settings['detail_enabled']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : detail_enabled<br/>If yes, stats detail is enabled</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">Max IO Ops/Event</span>
                <?php echo (isset($settings['reqs_per_event'])) ? $settings['reqs_per_event'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : reqs_per_event<br/>Max num IO ops processed within an event</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">CAS Enabled</span>
                <?php echo (isset($settings['cas_enabled'])) ? ucfirst($settings['cas_enabled']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : cas_enabled<br/>When no, CAS is not enabled for this server</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">TCP Listen Backlog</span>
                <?php echo (isset($settings['tcp_backlog'])) ? $settings['tcp_backlog'] : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : tcp_backlog<br/>TCP listen backlog</span></a>
                </span>
            </div>
            <div class="line">
                <span class="left setting">SASL Auth</span>
                <?php echo (isset($settings['auth_enabled_sasl'])) ? ucfirst($settings['auth_enabled_sasl']) : 'N/A on ' . $stats['version']; ?>
                <span class="right">
                    <a href="#" class="tooltip green">?<span>Internal name : auth_enabled_sasl<br/>SASL auth requested and enabled</span></a>
                </span>
            </div>
        </div>
<?php
}
# Viewing a cluster
elseif((isset($_GET['server'])) && ($cluster = $_ini->cluster($_GET['server'])))
{ ?>
        <div class="sub-header corner padding">Cluster <?php echo $_GET['server']; ?> <span class="green">Servers List</span></div>
        <div class="container corner padding">
<?php
    foreach($cluster as $server)
    { ?>
            <div class="line">
                <span class="left setting"><?php echo $server['hostname'] . ':' . $server['port']; ?></span>
                <span class="right"><a href="index.php?server=<?php echo $server['hostname'] . ':' . $server['port']; ?>" class="green">See Server Stats</a></span>
                <div class="line" style="margin-left:5px;">
                    <?php echo ($status[$server['hostname'] . ':' . $server['port']] != '') ? 'Version ' . $status[$server['hostname'] . ':' . $server['port']] . ', Uptime : ' . Library_Analysis::uptime($uptime[$server['hostname'] . ':' . $server['port']]) : 'Server did not respond'; ?>
                </div>
            </div>
<?php
    } ?>
    </div>
<?php
} ?>
    </div>
<?php
    # Making cache size stats
    $wasted_percent = sprintf('%.0u', $slabs['total_wasted'] / $stats['limit_maxbytes'] * 100);
    $used_percent = sprintf('%.0u', ($slabs['total_malloced'] - $slabs['total_wasted']) / $stats['limit_maxbytes'] * 100);
    $free_percent = sprintf('%.0u', ($stats['limit_maxbytes'] - $slabs['total_malloced']) / $stats['limit_maxbytes'] * 100);
?>
    <div class="size-4" style="float:left; padding-left:9px;clear:right;margin-top:18px;">
        <div class="sub-header corner padding">Cache Size <span class="green">Stats</span></div>
        <div class="container corner padding">
            <div class="line">
                <span class="left">Used</span>
                <?php echo Library_Analysis::byteResize($slabs['total_malloced']); ?>Bytes
                <span class="right"></span>
            </div>
            <div class="line">
                <span class="left">Total</span>
                <?php echo Library_Analysis::byteResize($stats['limit_maxbytes']); ?>Bytes
            </div>
            <div class="line">
                <span class="left">Wasted</span>
                <?php echo Library_Analysis::byteResize($slabs['total_wasted']); ?>Bytes
            </div>
            <!--
            <div class="line">
                <span class="left">Percent</span>
                <?php echo sprintf('%.1f', $stats['bytes'] / $stats['limit_maxbytes'] * 100, 1); ?>%
            </div>-->
         </div>
         <br/>

        <div class="sub-header corner padding">Cache Size <span class="green">Graphic</span></div>
        <div class="container corner padding">
            <div class="line">
                <img src="http://chart.apis.google.com/chart?chf=bg,s,F2F2F2&chs=280x225&cht=p&chco=B5463F|2A707B|FFFFFF&chd=t:<?php echo $wasted_percent; ?>,<?php echo $used_percent; ?>,<?php echo $free_percent; ?>&chdl=Wasted : <?php echo $wasted_percent; ?>%|Used : <?php echo $used_percent; ?>%|Free : <?php echo $free_percent; ?>%&amp;chdlp=b" alt="Cache Size by GoogleCharts" width="280" height="225"/>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding">Hit &amp; Miss Rate <span class="green">Graphic</span></div>
        <div class="container corner padding">
            <div class="line">
            <img src="http://chart.apis.google.com/chart?cht=bvg&amp;chd=t:<?php echo $stats['get_hits_percent']; ?>,<?php echo $stats['get_misses_percent']; ?>&amp;chs=280x225&amp;chl=Hit|Miss&amp;chf=bg,s,f2f2f2&amp;chco=2A707B|B5463F&amp;chxt=y&amp;chbh=a&amp;chm=N,000000,0,-1,11" alt="Cache Hit &amp; Miss Rate by GoogleChart" width="280" height="225"/>
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
