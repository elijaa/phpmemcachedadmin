<?php
/*
# Command issue
if((isset($response)) && ($response != array()))
{ ?>
    <div class="sub-header corner full-size padding">
        Result of <span class="green">
        <?php echo isset($_POST['request_command']) ? ucfirst($_POST['request_command']) : ucfirst($_GET['request_command']); ?></span>
        Command with <?php echo isset($_POST['request_api']) ? $_POST['request_api'] : $_GET['request_api']; ?> API
    </div>
    <div class="container corner padding">
    <?php
    foreach($response as $server => $result)
    { ?>
        <strong>Server <?php echo $server; ?></strong>
        <pre style="font-size:12px; overflow:visible;" class="full-size"><?php echo htmlentities(trim($result)); ?></pre>
    <?php
    }
    ?>
    </div>
<?php
}*/
# Configuration save
if(isset($write))
{
    if($write = true)
    { ?>
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