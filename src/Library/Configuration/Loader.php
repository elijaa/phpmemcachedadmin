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
 * Configuration class for editing, saving, ...
 *
 * @author elijaa@free.fr
 * @since 19/05/2010
 */
namespace App\Library\Configuration;

class Loader
{
    /**
     * @var null Singleton
     */
    protected static $_instance = null;

    /**
     * @var array Configuration needed keys and default values
     */
    protected $defaultConfig = [
        'stats_api' => 'Server',
        'slabs_api' => 'Server',
        'items_api' => 'Server',
        'get_api' => 'Server',
        'set_api' => 'Server',
        'delete_api' => 'Server',
        'flush_all_api' => 'Server',
        'connection_timeout' => 1,
        'max_item_dump' => 100,
        'refresh_rate' => 2,
        'memory_alert' => 80,
        'hit_rate_alert' => 90,
        'eviction_alert' => 0,
        'temp_dir_path' => '../../temp/',
        'servers' => [
            'Default' => [
                '127.0.0.1:11211' => [
                    'hostname' => '127.0.0.1',
                    'port' => 11211
                ]
            ]
        ]
    ];

    /**
     * @var array Storage
     */
    protected $config;

    /**
     * @var
     */
    protected $configFilePath = '../../.config.php';

    /**
     * Constructor, load configuration file and parse server list
     *
     * @return Void
     */
    protected function __construct(string $configFilePath = null)
    {
        if ($configFilePath) {
            $this->configFilePath = $configFilePath;
        }

        $this->config = $this->defaultConfig;

        if ($this->exists()) {
            $userConfig = require($this->configFilePath);
            $this->config = array_merge($this->config, $userConfig);
        }
    }

    /**
     * Get Loader singleton
     *
     * @return Loader
     */
    public static function singleton()
    {
        if (! isset(self::$_instance)) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    /**
     * Config key to retrieve
     * Return the value, or false if does not exists
     *
     * @param string $key Key to get
     *
     * @return mixed
     */
    public function get(string $key)
    {
        if (isset($this->config[$key])) {
            return $this->config[$key];
        }
        return false;
    }

    /**
     * @return string
     */
    public function tempDirPath(): string
    {
        return $this->config['temp_dir_path'];
    }

    /**
     * @return bool
     */
    public function isTempDirExists(): bool
    {
        $tempDirPath = $this->tempDirPath();
        return is_dir($tempDirPath);
    }

    /**
     * @return bool
     */
    public function isTempDirWritable(): bool
    {
        $tempDirPath = $this->tempDirPath();
        return is_writable($tempDirPath);
    }

    /**
     * Servers to retrieve from cluster
     * Return the value, or false if does not exists
     *
     * @param string $cluster Cluster to retrieve
     *
     * @return array
     */
    public function cluster($cluster)
    {
        if (isset($this->config['servers'][$cluster])) {
            return $this->config['servers'][$cluster];
        }
        return array();
    }

    /**
     * Check and return server data
     * Return the value, or false if does not exists
     *
     * @param string $server Server to retrieve
     *
     * @return array
     */
    public function server($server)
    {
        foreach ($this->config['servers'] as $cluster => $servers) {
            if (isset($this->config['servers'][$cluster][$server])) {
                return $this->config['servers'][$cluster][$server];
            }
        }
        return array();
    }

    /**
     * Config key to set
     *
     * @param string $key Key to set
     * @param mixed $value Value to set
     */
    public function set($key, $value)
    {
        $this->config[$key] = $value;
    }

    /**
     * @return bool
     */
    public function exists(): bool
    {
        return is_file($this->configFilePath);
    }

    /**
     * @return bool
     */
    public function isWritable(): bool
    {
        return is_writable($this->configFilePath);
    }

    /**
     * Return actual ini file path
     *
     * @return string
     */
    public function path(): string
    {
        return $this->configFilePath;
    }

    /**
     * Check if every ini keys are set
     * Return true if ini is correct, false otherwise
     *
     * @return boolean
     */
    public function check(): bool
    {
        # Checking configuration keys
        foreach (array_keys($this->defaultConfig) as $iniKey) {
            # Ini file key not set
            if (isset($this->config[$iniKey]) === false) {
                return false;
            }
        }
        return true;
    }

    /**
     * Write ini file
     * Return true if written, false otherwise
     *
     * @return boolean
     */
    public function write(): bool
    {
        if ($this->check()) {
            return is_numeric(file_put_contents($this->configFilePath, '<?php' . PHP_EOL . 'return ' . var_export($this->config, true) . ';'));
        }
        return false;
    }
}