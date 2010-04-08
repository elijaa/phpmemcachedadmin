<?php
if($response != array())
{ ?>
    <br/>
    <span class="title rounded" style="width:772px;">
        Result of <span class="stats"><?php echo $_GET['request_command']; ?></span> Command with key <span class="stats"><?php echo $_GET['request_key']; ?></span> and <?php echo $_GET['request_api']; ?> API
    </span>
    <div class="container rounded" style="width:772px; padding:7px 7px 7px 7px;">
    <?php
    foreach($response as $server => $result)
    { ?>
        <strong>Server <?php echo $server; ?> <span class="stats">response</span></strong>
        <pre style="width:772px;"><?php echo trim($result); ?></pre>
    <?php
    }
    ?>
    </div>
<?php
} ?>