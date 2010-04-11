<?php
if((isset($response)) && ($response != array()))
{ ?>
    <br/>
    <span class="title grey rounded" style="width:772px;">
        Result of <span class="green"><?php echo ucfirst($_GET['request_command']); ?></span> Command with <?php echo $_GET['request_api']; ?> API
    </span>
    <div class="container rounded" style="width:772px;padding:7px;">
    <?php
    foreach($response as $server => $result)
    { ?>
        <strong>Server <?php echo $server; ?></strong>
        <pre style="width:772px;"><?php echo htmlentities(trim($result)); ?></pre>
    <?php
    }
    ?>
    </div>
<?php
}
# Configuration save
if(isset($write))
{
    if($write = true)
    { ?>
    <br/>
    <span class="title grey rounded" style="width:772px;text-align:center;">
        Configuration saved
    </span>
<?php
    }
    else
    { ?>
    <span class="title grey rounded" style="width:772px;text-align:center;">
        Save failed
    </span>
<?php
    }
} ?>