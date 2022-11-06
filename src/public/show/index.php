<?php
/**
 * Copyright 2010 Cyrille Mahieux
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations
 * under the License.
 *
 * ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°>
 *
 * Live Stats top style
 *
 * @author Cyrille Mahieux : elijaa(at)free.fr
 * @since 12/04/2010
 */

# Require
use App\Library\App;
use App\Library\Command\Factory;
use App\Library\Command\Server;

require_once __DIR__ .'/../../bootstrap.php';

$requestServer = $_GET['server'] ?? null;
if ($requestServer) {
    $app = App::getInstance();
    $serverConfig = $app->server($requestServer);

    if ($serverConfig) {
        /** @var Server $memcachedServer */
        $memcachedServer = Factory::api('Server');
        $keys = $memcachedServer->keys($serverConfig['hostname'], $serverConfig['port']);
    }
}

require __DIR__ .'/../../view/header.php';
require __DIR__ .'/../../view/server_select.php';
if (isset($keys)) {
    require __DIR__ . '/../../view/show/data.php';
}
require __DIR__ .'/../../view/footer.php';
