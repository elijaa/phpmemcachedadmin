    <br/>
    <div style="float:left;">
        <span class="title grey rounded">Slabs <span class="green">Stats</span></span>
        <div class="container rounded">
            <div class="row">
                <div class="left">Slabs Allocated</div>
                <div class="full"><?php echo $slabs['active_slabs']; ?></div>
            </div>
            <div class="row">
                <div class="left">Slabs Used</div>
                <div class="full"><?php echo $slabs['used_slabs']; ?></div>
            </div>
            <div class="row">
                <div class="left">Memory Used</div>
                <div class="full"><?php echo Library_Analysis::byteResize($slabs['total_malloced']); ?></div>
            </div>
            <div class="row">
                <div class="left">Wasted</div>
                <div class="full"><?php echo Library_Analysis::byteResize($slabs['total_wasted']); ?></div>
            </div>
        </div>

    </div>
    <div style="float:left; padding-left:10px;">
        <form method="get" id="flushForm" action="commands.php">
        <div class="serverlist rounded" style="padding: 5px 12px 4px 32px;height:18px;margin:0px;width:211px;">
            <a href="?server=<?php echo $_GET['server']; ?>">See Stats</a> |
            <input type="hidden" name="request_server" value="<?php echo $_GET['server']; ?>"/>
            <input type="hidden" name="request_api" value="<?php echo $_ini->get('flush_all_api'); ?>"/>
            <input type="hidden" name="request_command" value="flush_all"/>
            <a href="#" onclick="document.getElementById('flushForm').submit();">Flush this Server</a>
        </div>
        </form>
        <div class="container rounded" style="width:506px;padding:7px;margin-top:34px;">
            <div class="row">
                For more informations about memcached slabs stats, see memcached protocol
                <a href="http://github.com/memcached/memcached/blob/master/doc/protocol.txt#L470" target="_blank"><span class="green">here</span></a>
            </div>
        </div>
    </div>

    <table style="width:772px;" cellspacing="0" cellpadding="0">
        <tr>
<?php
$actualSlab = 0;

# Slabs parsing
foreach($slabs as $id => $slab)
{
    # If Slab is Used
    if(is_numeric($id) && ($slab['used_chunks'] > 0))
    {
        # Making a new line
        if($actualSlab >= 3)
        {
?>
        </tr>
        <tr>
<?php
            $actualSlab = 0;
        }
        # Making a new cell
        else
        {
?>
        <td <?php if($actualSlab > 0) { echo 'style="padding-left:10px;"'; } ?>>
            <br/>
            <span class="title grey rounded">
                Slab <?php echo $id; ?> <span class="green">Stats</span>
                <span style="float:right;"><a href="?server=<?php echo $_GET['server']; ?>&amp;show=items&amp;slab=<?php echo $id; ?>">See Slab Items</a></span>
            </span>
                <div class="container rounded">
                    <div class="row">
                        <div class="left">Chunk Size</div>
                        <div class="full"><?php echo Library_Analysis::byteResize($slab['chunk_size']); ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Used Chunk</div>
                        <div class="full"><?php echo $slab['used_chunks']; ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Total Chunk</div>
                        <div class="full"><?php echo $slab['total_chunks']; ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Total Page</div>
                        <div class="full"><?php echo $slab['total_pages']; ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Wasted</div>
                        <div class="full"><?php echo Library_Analysis::byteResize($slab['mem_wasted']); ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Hits</div>
                        <div class="full"><?php echo $slab['request_rate']; ?> Request/sec</div>
                    </div>
                    <div class="row">
                        <div class="left">Evicted</div>
                        <div class="full"><?php echo $slab['items:evicted']; ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Evicted Last</div>
                        <div class="full"><?php echo Library_Analysis::uptime($slab['items:evicted_time']); ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Out of Memory</div>
                        <div class="full"><?php echo $slab['items:outofmemory']; ?></div>
                    </div>
                    <!--<div class="row">
                        <div class="left">Tail Repairs</div>
                        <div class="full"><?php echo $slab['items:tailrepairs']; ?></div>
                    </div>-->
                </div>
            </td>
<?php
            $actualSlab++;
        }
    }
?>
<?php
}
for(true; $actualSlab < 3 ; $actualSlab++)
{
    echo '<td style="width:260px;"></td>';
}
?>
        </tr>
    </table>