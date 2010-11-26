<?php
# Server seems down
if((isset($stats)) && (($stats === false) || ($stats == array())))
{ ?>
    <div class="header corner full-size padding" style="margin-top:18px;text-align:center;">
        <?php
        # Asking server of cluster stats
        if(isset($_GET['server']))
        {
            echo (is_array($cluster)) ? 'All servers from Cluster ' . $_GET['server'] : 'Server '  . $_GET['server'], ' did not respond !';
        }
        # All servers stats
        else
        {
            echo 'Servers did not respond !';
        } ?>
    </div>
    <div class="container corner full-size padding">
        <span class="left">Error message</span>
        <br/>
        <?php echo Library_Data_Error::last(); ?>
        <br/>
        <br/>
        Please check above error message, your <a href="configure.php" class="green">configuration</a> or your server status and retry
    </div>
<?php
}
# No slabs used
elseif((isset($slabs)) && ($slabs === false))
{
?>
    <div class="header corner full-size padding" style="margin-top:18px;font-size:22px;text-align:center;">
        No slabs used in this server !
    </div>
    <div class="container corner full-size padding">
        Maybe this server is not used, check your <a href="configure.php" class="green">configuration</a> or your server status and retry
    </div>
<?php
}