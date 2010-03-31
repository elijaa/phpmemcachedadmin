    <br/>
    <div style="float:left;">
        <span class="title rounded">Slabs <span class="stats">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Slabs Allocated</div>
                <div class="full"><?php echo $slabs['active_slabs']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Slabs Used</div>
                <div class="full"><?php echo $slabs['used_slabs']; ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Memory Used</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($slabs['total_malloced']); ?></div>
                <div class="clear"></div>
            </div>
            <div class="row">
                <div class="left">Wasted</div>
                <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($slabs['total_wasted']); ?></div>
                <div class="clear"></div>
            </div>
        </div>
        <br/>

<?php
# Calculing the number of Slab to show at each columns
$slab_per_line = round($slabs['used_slabs'] / 3);
$actual_line = 0;

# Slabs parsing
foreach($slabs as $id => $slab)
{
    # If Slab is Used
    if(is_numeric($id) && ($slab['used_chunks'] > 0))
    {
        $actual_line++;
        if($actual_line > $slab_per_line)
        {
            $actual_line = 0;
?>
    </div>
    <div style="float:left; padding-left:10px;">
        <div style="min-height:147px;">
        </div>
<?php
    }
?>
        <span class="title rounded">Slab <?php echo $id; ?> <span class="stats">Stats</span>
        <span style="float:right;"><a href="?server=<?php echo $_GET['server']; ?>&amp;show=items&amp;slab=<?php echo $id; ?>">See Items</a></span></span>
            <div class="container rounded">
                <div class="row">
                    <div class="left">Chunk Size</div>
                    <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($slab['chunk_size']); ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Used Chunk</div>
                    <div class="full"><?php echo $slab['used_chunks']; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Total Chunk</div>
                    <div class="full"><?php echo $slab['total_chunks']; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Total Page</div>
                    <div class="full"><?php echo $slab['total_pages']; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Wasted</div>
                    <div class="full"><?php echo MemCacheAdmin_Analysis::byteResize($slab['mem_wasted']); ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Hits</div>
                    <div class="full"><?php echo $slab['request_rate']; ?> Request/sec</div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Evicted</div>
                    <div class="full"><?php echo $slab['items:evicted']; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Evicted Last</div>
                    <div class="full"><?php echo MemCacheAdmin_Analysis::uptime($slab['items:evicted_time']); ?></div>
                    <div class="clear"></div>
                </div>
<!--                <div class="row">
                    <div class="left">Out of Memory</div>
                    <div class="full"><?php echo $slab['items:outofmemory']; ?></div>
                    <div class="clear"></div>
                </div>
                <div class="row">
                    <div class="left">Tail Repairs</div>
                    <div class="full"><?php echo $slab['items:tailrepairs']; ?></div>
                    <div class="clear"></div>
                </div>-->
            </div>
            <br/>
<?php
    }
}
?>
    </div>