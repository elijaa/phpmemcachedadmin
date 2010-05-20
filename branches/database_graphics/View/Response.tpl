<?php
if((isset($response)) && ($response != array()))
{ ?>
    <div class="ui-state-highlight ui-corner-all size-1col" style="padding:2px;">
        Result of <span class="green">
        <?php echo isset($_POST['request_command']) ? ucfirst($_POST['request_command']) : ucfirst($_GET['request_command']); ?></span>
        Command with <?php echo isset($_POST['request_api']) ? $_POST['request_api'] : $_GET['request_api']; ?> API
    </div>
    <div class="ui-corner-all ui-widget-content size-1col" style="padding:2px;">
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
    <div class="ui-state-highlight ui-corner-all size-1col" style="margin-bottom:12px;padding:2px;">
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