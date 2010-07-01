    <br/>
    <div style="float:left;">
        <div class="sub-header corner padding size-3cols">Get <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['get_hits']); ?>
                <span class="right">[<?php echo $stats['get_hits_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['get_misses']); ?>
                <span class="right">[<?php echo $stats['get_misses_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['get_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Set <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Total</span>
                <?php echo Library_Analysis::hitResize($stats['cmd_set']); ?>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['set_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Delete <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['delete_hits']); ?>
                <span class="right">[<?php echo $stats['delete_hits_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['delete_misses']); ?>
                <span class="right">[<?php echo $stats['delete_misses_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['delete_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Cas <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['cas_hits']); ?>
                <span class="right">[<?php echo $stats['cas_hits_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['cas_misses']); ?>
                <span class="right">[<?php echo $stats['cas_misses_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Bad Value</span>
                <?php echo Library_Analysis::hitResize($stats['cas_badval']); ?>
                <span class="right">[<?php echo $stats['cas_badval_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['cas_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Increment <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['incr_hits']); ?>
                <span class="right">[<?php echo $stats['incr_hits_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['incr_misses']); ?>
                <span class="right">[<?php echo $stats['incr_misses_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['incr_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Decrement <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Hits</span>
                <?php echo Library_Analysis::hitResize($stats['decr_hits']); ?>
                <span class="right">[<?php echo $stats['decr_hits_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Miss</span>
                <?php echo Library_Analysis::hitResize($stats['decr_misses']); ?>
                <span class="right">[<?php echo $stats['decr_misses_percent']; ?>%]</span>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['decr_rate']; ?> Request/sec
            </div>
        </div>
    </div>

    <div style="float:left; padding-left:9px;">
<?php
# Viewing a server
if(isset($_GET['server']))
{ ?>
        <form method="post" id="flushForm" action="commands.php">
        <div class="serverlist rounded" style="padding: 5px 12px 4px 12px;height:18px;margin:0px;">
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
        <div class="sub-header corner padding size-3cols">Server <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Uptime</span>
                <?php echo Library_Analysis::uptime($stats['uptime']); ?>
            </div>
            <div class="line padding">
                <span class="left">Memcached</span>
                Version <?php echo $stats['version']; ?>
            </div>

        <!--</div>
        <br/>

        <div class="sub-header corner padding size-3cols">Connection <span class="green">Stats</span></div>
        <div class="container corner">-->
            <div class="line padding" style="margin-top:6px;">
                <span class="left">Curr Connections</span>
                <?php echo $stats['curr_connections']; ?>
            </div>
            <div class="line padding">
                <span class="left">Total Connections</span>
                <?php echo Library_Analysis::hitResize($stats['total_connections']); ?>
            </div>
        <!--</div>
        <br/>

        <div class="sub-header corner padding size-3cols">Item <span class="green">Stats</span></div>
        <div class="container corner">-->
            <div class="line padding" style="margin-top:6px;">
                <span class="left">Current Items</span>
                <?php echo Library_Analysis::hitResize($stats['curr_items']); ?>
            </div>
            <div class="line padding">
                <span class="left">Total Items</span>
                <?php echo Library_Analysis::hitResize($stats['total_items']); ?>
            </div>
        </div>
        <br/>
        <div class="sub-header corner padding size-3cols">Eviction <?php if(isset($stats['reclaimed'])) { echo ' &amp; Reclaimed'; } ?> <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Items Eviction</span>
                <?php echo Library_Analysis::hitResize($stats['evictions']); ?>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['eviction_rate']; ?> Eviction/sec
            </div>
<?php
# Memcached version 1.4.5 and above
if(isset($stats['reclaimed']))
{ ?>
            <div class="line padding">
                <span class="left">Reclaimed</span>
                <?php echo Library_Analysis::hitResize($stats['reclaimed']); ?>
            </div>
            <div class="line padding">
                <span class="left">Rate</span>
                <?php echo $stats['reclaimed_rate']; ?> Reclaimed/sec
            </div>
<?php
} ?>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Network <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Bytes Read</span>
                <?php echo Library_Analysis::byteResize($stats['bytes_read']); ?>Bytes
            </div>
            <div class="line padding">
                <span class="left">Bytes Written</span>
                <?php echo Library_Analysis::byteResize($stats['bytes_written']); ?>Bytes
            </div>
        </div>
        <br/>
    </div>

    <div style="float:left; padding-left:9px;clear:right;">
        <div class="sub-header corner padding size-3cols">Cache Size <span class="green">Stats</span></div>
        <div class="container corner">
            <div class="line padding">
                <span class="left">Used</span>
                <?php echo Library_Analysis::byteResize($stats['bytes']); ?>Bytes
            </div>
            <div class="line padding">
                <span class="left">Total</span>
                <?php echo Library_Analysis::byteResize($stats['limit_maxbytes']); ?>Bytes
            </div>
         </div>
         <br/>

        <div class="sub-header corner padding size-3cols">Cache Size <span class="green">Graphic</span></div>
        <div class="container corner">
            <div class="line padding">
                <img src="http://chart.apis.google.com/chart?cht=p&amp;chd=t:<?php echo $stats['bytes_percent']; ?>,<?php echo (100 - $stats['bytes_percent']); ?>&amp;chs=300x220&amp;chl=Used|Free&amp;chf=bg,s,f2f2f2&amp;chco=B5463F|2A707B" alt="Cache Size by GoogleChart" width="300" height="220"/>
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Cache Request <span class="green">Stats</span></div>
         <div class="container corner">
            <div class="line padding">
                <span class="left">Request Rate</span>
                <?php echo $stats['request_rate']; ?> Request/sec
            </div>
            <div class="line padding">
                <span class="left">Hit Rate</span>
                <?php echo $stats['hit_rate']; ?> Request/sec
            </div>
            <div class="line padding">
                <span class="left">Miss Rate</span>
                <?php echo $stats['miss_rate']; ?> Request/sec
            </div>
        </div>
        <br/>

        <div class="sub-header corner padding size-3cols">Hit &amp; Miss Rate <span class="green">Graphic</span></div>
         <div class="container corner">
            <div class="line padding">
            <img src="http://chart.apis.google.com/chart?cht=bvg&amp;chd=t:<?php echo $stats['hit_percent']; ?>,<?php echo $stats['miss_percent']; ?>&amp;chs=300x180&amp;chl=Hit|Miss&amp;chf=bg,s,f2f2f2&amp;chco=2A707B|B5463F&amp;chxt=y&amp;chbh=86&amp;chm=N,000000,0,-1,11" alt="Cache Hit &amp; Miss Rate by GoogleChart" width="300" height="180"/>
            </div>
        </div>
    </div>