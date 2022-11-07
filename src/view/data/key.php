<div class="breadcrumbs">
    <a href="/">Home</a> > <a href="/data/?server=<?= htmlspecialchars($requestServer, ENT_QUOTES) ?>">Data</a> > <?= htmlspecialchars($key) ?>
</div>

<?php if (isset($data)) : ?>
    <table border="1">
        <tr>
            <td>Key:</td>
            <td><?= htmlspecialchars($key) ?></td>
        </tr>
        <tr>
            <td>Data:</td>
            <td><?= htmlspecialchars($data) ?></td>
        </tr>
    </table>

<?php endif ?>
