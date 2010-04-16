    <br/>
    <div style="float:left;">
        <span class="title grey rounded">Get <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['get_hits']); ?></div>
                <div class="right">[<?php echo $stats['get_hits_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['get_misses']); ?></div>
                <div class="right">[<?php echo $stats['get_misses_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['get_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Set <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Total</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['cmd_set']); ?></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['set_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Delete <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['delete_hits']); ?></div>
                <div class="right">[<?php echo $stats['delete_hits_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['delete_misses']); ?></div>
                <div class="right">[<?php echo $stats['delete_misses_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['delete_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Cas <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['cas_hits']); ?></div>
                <div class="right">[<?php echo $stats['cas_hits_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['cas_misses']); ?></div>
                <div class="right">[<?php echo $stats['cas_misses_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Bad Value</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['cas_badval']); ?></div>
                <div class="right">[<?php echo $stats['cas_badval_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['cas_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Increment <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['incr_hits']); ?></div>
                <div class="right">[<?php echo $stats['incr_hits_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['incr_misses']); ?></div>
                <div class="right">[<?php echo $stats['incr_misses_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['incr_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Decrement <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['decr_hits']); ?></div>
                <div class="right">[<?php echo $stats['decr_hits_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo Library_Analysis::hitResize($stats['decr_misses']); ?></div>
                <div class="right">[<?php echo $stats['decr_misses_percent']; ?>%]</div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['decr_rate']; ?> Request/sec</div>
            </div>
        </div>
    </div>

    <div style="float:left;padding-left:10px;">
<?php
# Viewing a server
if(isset($_GET['server']))
{ ?>
        <form method="post" id="flushForm" action="commands.php">
        <div class="serverlist rounded submenu">
            <a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">See Slabs Stats</a> |
            <input type="hidden" name="request_server" value="<?php echo $_GET['server']; ?>"/>
            <input type="hidden" name="request_api" value="<?php echo $_ini->get('flush_all_api'); ?>"/>
            <input type="hidden" name="request_command" value="flush_all"/>
            <a href="#" onclick="document.getElementById('flushForm').submit();">Flush this Server</a>
        </div>
        </form>
        <br/>
<?php
} ?>
        <span class="title grey rounded">Server <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Uptime</div>
                <div class="full"><?php echo Library_Analysis::uptime($stats['uptime']); ?></div>
            </div>
            <div class="row">
                <div class="left">Memcached</div>
                <div class="full">Version <?php echo $stats['version']; ?></div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Connection <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Current</div>
                <div class="full"><?php echo $stats['curr_connections']; ?></div>
            </div>
            <div class="row">
                <div class="left">Total</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['total_connections']); ?></div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Item <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Current Items</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['curr_items']); ?></div>
            </div>
            <div class="row">
                <div class="left">Total Items</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['total_items']); ?></div>
            </div>
            <div class="row">
                <div class="left">Garbage Items</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['evictions']); ?></div>
            </div>
            <?php
            # Memcached 1.4.5 new stats
            if(isset($stats['reclaimed']))
            { ?>
            <div class="row">
                <div class="left">Reclaimed Items</div>
                <div class="full"><?php echo Library_Analysis::hitResize($stats['reclaimed']); ?></div>
            </div>
            <?php
            } ?>
        </div>
        <br/>

        <span class="title grey rounded">Network <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Bytes Read</div>
                <div class="full"><?php echo Library_Analysis::byteResize($stats['bytes_read']); ?>Bytes</div>
            </div>
            <div class="row">
                <div class="left">Bytes Written</div>
                <div class="full"><?php echo Library_Analysis::byteResize($stats['bytes_written']); ?>Bytes</div>
            </div>
        </div>
        <br/>
    </div>

    <div style="float:left; padding-left:10px;clear:right;">
        <span class="title grey rounded">Cache Size <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Used</div>
                <div class="full"><?php echo Library_Analysis::byteResize($stats['bytes']); ?>Bytes</div>
            </div>
            <div class="row">
                <div class="left">Total</div>
                <div class="full"><?php echo Library_Analysis::byteResize($stats['limit_maxbytes']); ?>Bytes</div>
            </div>
         </div>
         <br/>

        <span class="title grey rounded">Cache Size <span class="green">Graphic</span></span>
        <div class="container rounded">
            <div class="row">
                <img src="http://chart.apis.google.com/chart?cht=p&amp;chd=t:<?php echo $stats['bytes_percent']; ?>,<?php echo (100 - $stats['bytes_percent']); ?>&amp;chs=248x176&amp;chl=Used|Free&amp;chf=bg,s,DBDBDB&amp;chco=B5463F|2A707B" alt="Cache Size by GoogleChart" width="248" height="176"/>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Cache Request <span class="green">Stats</span></span>
         <div class="container rounded">
            <div class="row">
                <div class="left">Request Rate</div>
                <div class="full"><?php echo $stats['request_rate']; ?> Request/sec</div>
            </div>
            <div class="row">
                <div class="left">Hit Rate</div>
                <div class="full"><?php echo $stats['hit_rate']; ?> Request/sec</div>
            </div>
            <div class="row">
                <div class="left">Miss Rate</div>
                <div class="full"><?php echo $stats['miss_rate']; ?> Request/sec</div>
            </div>
        </div>
        <br/>

        <span class="title grey rounded">Hit &amp; Miss Rate <span class="green">Graphic</span></span>
         <div class="container rounded">
            <div class="row" style="text-align:center;">
            <img src="http://chart.apis.google.com/chart?cht=bvg&amp;chd=t:<?php echo $stats['hit_percent']; ?>,<?php echo $stats['miss_percent']; ?>&amp;chs=248x176&amp;chl=Hit|Miss&amp;chf=bg,s,DBDBDB&amp;chco=2A707B|B5463F&amp;chxt=y&amp;chbh=86&amp;chm=N,000000,0,-1,11" alt="Cache Hit &amp; Miss Rate by GoogleChart" width="248" height="176"/>
            </div>
        </div>
    </div>