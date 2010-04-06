    <div class="serverlist rounded" style="padding: 3px 7px 3px 7px; width: 772px;">Actually seeing
        <select class="serverlist menu" onchange="changeServer(this)">
        <option value="" <?php if(!isset($_GET['server']) || ($_GET['server'] == '')) { echo 'selected="selected"'; } ?>>All Servers</option>
<?php
# Servers
foreach($_ini['server'] as $server => $port)
{ ?>
        <option value="<?php echo $server; ?>" <?php if((isset($_GET['server'])) && ($_GET['server'] == $server)) { echo 'selected="selected"'; } ?>>
            <?php echo $server; ?>
        </option>
<?php
} ?>
        </select>
<?php
# Viewing a server
if(isset($_GET['server']))
{ ?>
<?php
    if(!isset($_GET['show']) || ($_GET['show'] == 'items'))
    { ?>
        | <a href="?server=<?php echo $_GET['server']; ?>&amp;show=slabs">See Slabs Stats</a>
<?php
    }
    elseif($_GET['show'] == 'slabs')
    { ?>
        | <a href="?server=<?php echo $_GET['server']; ?>">See Server Stats</a>
<?php
    }
} ?>
        | <a href="commands.php">Execute Commands on Servers</a> | <a href="configure.php">Edit Configuration</a>
    </div>