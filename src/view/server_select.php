<?php
use App\Library\Html\Components;
?>

<div style="margin: 10px 0;">
    Select cluster: <?= Components::serverSelect(
        'server_select',
        $_REQUEST['server'] ?? null,
        'list',
        'onchange="changeServer(this)"'
    ); ?>
</div>
