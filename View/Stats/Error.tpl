<?php
# Server seems down
if((isset($stats)) && ($stats === false))
{ ?>
    <div class="header corner full-size padding" style="margin-top:18px;font-size:22px;text-align:center;">
        Error : Server did not respond !
    </div>
    <div class="container corner" style="padding:9px;">
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
    <div class="container corner" style="padding:9px;">
        Maybe this server is not used, check your <a href="configure.php" class="green">configuration</a> or your server status and retry
    </div>
<?php
}