<?php
if((isset($response)) && ($response != array()))
{ ?>
    <span class="title grey rounded" style="width:810px;">
        Result of <span class="green">
        <?php echo isset($_POST['request_command']) ? ucfirst($_POST['request_command']) : ucfirst($_GET['request_command']); ?></span>
        Command with <?php echo isset($_POST['request_api']) ? $_POST['request_api'] : $_GET['request_api']; ?> API
    </span>
    <div class="container rounded" style="width:810px;padding:7px;">
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
    <div class="ui-state-highlight ui-corner-all size-1col padding" style="margin-bottom:12px;">
        <span class="ui-icon ui-icon-check" style="float:left;margin-right:0.3em;">Sucess</span>Configuration saved
    </div>
<?php
    }
    else
    { ?>
    <span class="ui-state-error" style="margin-bottom:12px;">
        Save failed
    </span>
<?php
    }
} ?>