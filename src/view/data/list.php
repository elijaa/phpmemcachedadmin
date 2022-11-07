<?php if (isset($keys)) : ?>
    <table border="1">
        <tr>
            <th>Key</th>
            <th>Size (bytes)</th>
            <th>TTL</th>
        </tr>
        <?php foreach ($keys as $key) : ?>
            <tr>
                <td><a href="/key?name=<?= htmlspecialchars($key['name'], ENT_QUOTES) ?>&server=<?= htmlspecialchars($requestServer, ENT_QUOTES) ?>"><?= htmlspecialchars($key['name']) ?></a></td>
                <td align="right"><?= $key['size'] ?></td>
                <td>
                    <?php if ($key['ttl']) : ?>
                        <?= date('Y-m-d H:i:s', $key['ttl']) ?>
                    <?php else : ?>
                            ∞
                    <?php endif ?>
                </td>
            </tr>
        <?php endforeach ?>
    </table>
<?php endif ?>
