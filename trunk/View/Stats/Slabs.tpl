    <br/>
    <div style="float:left;">
        <span class="title rounded">Slabs <span class="stats">Stats</span></span>
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
        <br/>

    </div>
    <div style="float:left; padding-left:10px;">
        <div class="serverlist rounded" style="padding: 5px 12px 4px 12px; height: 18px; margin:0px;">
            <a href="?server=<?php echo $_GET['server']; ?>">See Server Stats</a>
            |
            <a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">Flush this Server</a>
        </div>
        <br/>
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
            <span class="title rounded">
                Slab <?php echo $id; ?> <span class="stats">Stats</span>
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
                <!--<div class="row">
                        <div class="left">Out of Memory</div>
                        <div class="full"><?php echo $slab['items:outofmemory']; ?></div>
                    </div>
                    <div class="row">
                        <div class="left">Tail Repairs</div>
                        <div class="full"><?php echo $slab['items:tailrepairs']; ?></div>
                    </div>-->
                </div>
                <br/>
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