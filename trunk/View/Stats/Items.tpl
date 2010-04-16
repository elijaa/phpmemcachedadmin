    <br/>
    <span class="title grey rounded" style="width:810px;">
        Items in Slab <?php echo $_GET['slab']; ?>, only showing first <?php echo $_ini->get('max_item_dump'); ?> items
        <span style="float:right;"><a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">Back to Server Slabs</a></span>
    </span>
    <div class="container rounded" style="width:810px;padding:7px;">
<?php
$notFirst = false;

# Items
foreach($items as $key => $data)
{
    # Checking if first item
    if($notFirst) { echo '<hr/>'; }

    # Displaying item line
?>
        <form>
        <a class="green" href="index.php?server=<?php echo $_GET['server']; ?>&amp;show=items&amp;slab=<?php echo $_GET['slab']; ?>&amp;request_key=<?php echo $key; ?>&amp;request_api=<?php echo $_ini->get('get_api'); ?>&amp;request_command=get"><?php echo $key; ?></a>
        <br/>
        <strong>Size</strong> : <?php echo Library_Analysis::byteResize($data[0]); ?>Bytes,
        <strong>Expiration</strong> : <?php echo Library_Analysis::uptime($data[1] - time()); ?>
        </form>
<?php
    # Checking for item content
    if((isset($_GET['key'])) && ($_GET['key'] == $key))
    { ?>
        <br/>
        <code>
<?php echo htmlentities(chunk_split($item, 150)); ?>
        </code>
<?php
    }
    # First item done
    $notFirst = true;
} ?>
    </div>