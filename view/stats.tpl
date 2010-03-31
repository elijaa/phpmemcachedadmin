    <br/>
    <div style="float:left;">
        <span class="title rounded">Get <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo $stats['get_hits']; ?></div>
                <div class="right">[<?php echo $stats['get_hits_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo $stats['get_misses']; ?></div>
                <div class="right">[<?php echo $stats['get_misses_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['get_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Set <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Total</div>
                <div class="middle"><?php echo $stats['cmd_set']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['set_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Delete <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo $stats['delete_hits']; ?></div>
                <div class="right">[<?php echo $stats['delete_hits_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo $stats['delete_misses']; ?></div>
                <div class="right">[<?php echo $stats['delete_misses_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['delete_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Cas <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo $stats['cas_hits']; ?></div>
                <div class="right">[<?php echo $stats['cas_hits_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo $stats['cas_misses']; ?></div>
                <div class="right">[<?php echo $stats['cas_misses_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Bad Value</div>
                <div class="middle"><?php echo $stats['cas_badval']; ?></div>
                <div class="right">[<?php echo $stats['cas_badval_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['cas_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Increment <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo $stats['incr_hits']; ?></div>
                <div class="right">[<?php echo $stats['incr_hits_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo $stats['incr_misses']; ?></div>
                <div class="right">[<?php echo $stats['incr_misses_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['incr_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Decrement <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Hits</div>
                <div class="middle"><?php echo $stats['decr_hits']; ?></div>
                <div class="right">[<?php echo $stats['decr_hits_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss</div>
                <div class="middle"><?php echo $stats['decr_misses']; ?></div>
                <div class="right">[<?php echo $stats['decr_misses_percent']; ?>%]</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Rate</div>
                <div class="full"><?php echo $stats['decr_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <div class="title rounded" style="width:788px; display:float; position:absolute; text-align:center;">
            <a href="http://memcached.org/" target="_blank">memcached home</a>
             - <a href="http://www.pecl.php.net/package/memcache" target="_blank">PECL memcache</a>
             - <a href="http://www.pecl.php.net/package/memcached" target="_blank">PECL memcached</a>
            <br/>
            Styling &amp; Banner image Copyright (c) 2009 Dormando
        </div>

    </div>

    <div style="float:left; padding-left:10px;">
        <span class="title rounded">Server <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Uptime</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::uptime($stats['uptime']); ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Memcached</div>
                <div class="full">Version <?php echo $stats['version']; ?></div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Connection <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Current</div>
                <div class="full"><?php echo $stats['curr_connections']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Total</div>
                <div class="full"><?php echo $stats['total_connections']; ?></div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Item <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Current Items</div>
                <div class="middle"><?php echo $stats['curr_items']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Total Items</div>
                <div class="right"><?php echo $stats['total_items']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Garbage Items</div>
                <div class="middle"><?php echo $stats['evictions']; ?></div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Network <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Bytes Read</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($stats['bytes_read']); ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Bytes Written</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($stats['bytes_written']); ?></div>
                <div class="clear"></div>
            </div>
        </div>
    </div>

    <div style="float:left; padding-left:10px;">
        <span class="title rounded">Cache Size <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Used</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($stats['bytes']); ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Total</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($stats['limit_maxbytes']); ?></div>
                <div class="clear"></div>
            </div>
         </div>
         <br/>

        <span class="title rounded">Cache Size <span class="stats">Graphic</span></span>
        <div class="container rounded">
            <div class="row">
                <img src="http://chart.apis.google.com/chart?cht=p&amp;chd=t:<?php echo $stats['bytes_percent']; ?>,<?php echo (100 - $stats['bytes_percent']); ?>&amp;chs=240x176&amp;chl=Used|Free&amp;chf=bg,s,DBDBDB&amp;chco=B5463F|2A707B" alt="Cache Size by GoogleChart" width="240" height="176"/>
            </div>
        </div>
        <br/>

        <span class="title rounded">Cache Request <span class="stats">Stats</span></span>
         <div class="container rounded">
            <div class="row">
                <div class="left">Request Rate</div>
                <div class="full"><?php echo $stats['request_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Hit Rate</div>
                <div class="full"><?php echo $stats['hit_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Miss Rate</div>
                <div class="full"><?php echo $stats['miss_rate']; ?> Request/sec</div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

        <span class="title rounded">Hit &amp; Miss Rate <span class="stats">Graphic</span></span>
         <div class="container rounded">
            <div class="row">
            <img src="http://chart.apis.google.com/chart?cht=bvg&amp;chd=t:<?php echo $stats['hit_percent']; ?>,<?php echo $stats['miss_percent']; ?>&amp;chs=240x176&amp;chl=Hit|Miss&amp;chf=bg,s,DBDBDB&amp;chco=2A707B|B5463F&amp;chxt=y&amp;chbh=86&amp;chm=N,000000,0,-1,11" alt="Cache Hit &amp; Miss Rate by GoogleChart" width="240" height="176"/>
            </div>
        </div>
    </div>