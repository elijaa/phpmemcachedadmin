<?php if (isset($keys)) : ?>
    <table border="1">
        <tr>
            <th>Key</th>
            <th>Size (bytes)</th>
            <th>TTL</th>
        </tr>
        <?php foreach ($keys as $key) : ?>
            <tr>
                <td><?= htmlspecialchars($key['name']) ?></td>
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
