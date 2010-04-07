    <br/>
    <div class="title rounded">Items in Slab <?php echo $_GET['slab']; ?>, only showing first <?php echo $_ini['max_item_dump']; ?> items</div>
        <div class="container rounded" style="width:772px; padding:7px 7px 7px 7px;">
<?php
$notFirst = false;

# Items
foreach($items as $key => $data)
{
    # Checking if first item
    if($notFirst) { echo '<hr/>'; }

    # Displaying item line
?>
        <strong><a style="color:#A0A0A0;" href="<?php echo str_replace('&', '&amp;', preg_replace('/&key=(.)*/', '', $_SERVER['REQUEST_URI'])); ?>&amp;key=<?php echo $key; ?>"><?php echo $key; ?></a>
        Size</strong> : <?php echo Library_Analysis::byteResize($data[0]); ?>,
        <strong>Expiration</strong> : <?php echo Library_Analysis::uptime($data[1] - time()); ?>
<?php
    # Checking for item content
    if((isset($_GET['key'])) && ($_GET['key'] == $key))
    {
?>
        <div>
        <?php echo htmlentities(chunk_split($item, 150)); ?>
        </div>
<?php
    }
    # First item done
    $notFirst = true;
}
?>
    </div>