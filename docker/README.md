L'idée est de fournir une image docker simple et minimale permettant d'utiliser phpmemcachedadmin.
L'image est basée sur alpine:3 et utilise les packages php7-apache2 et php7-xxx standard.



Pour générer l'image docker "phpmemcachedadmin", il existe 2 options

 

    docker-compose-build

ou

    cd phpmemcachedadmin
    ./build.sh

Pour démarrer un environnement de test, il suffit de démarrer le docker-compose.yml 

    docker-compose up 

Vous pouvez accèder à l'application via l'url [http://localhost/](http://localhost/)

Pour configurer le ou les serveurs memcached accessibles via phpmemcachedadmin, il suffit d'écraser le fichier **/var/www/localhost/htdocs/Config/Memcache.php** dans votre docker-compose.yml ou dans votre déploiment Kubernetes.


    <?php
    return array (
      'stats_api' => 'Server',
      'slabs_api' => 'Server',
      'items_api' => 'Server',
      'get_api' => 'Server',
      'set_api' => 'Server',
      'delete_api' => 'Server',
      'flush_all_api' => 'Server',
      'connection_timeout' => '1',
      'max_item_dump' => '100',
      'refresh_rate' => 2,
      'memory_alert' => '80',
      'hit_rate_alert' => '90',
      'eviction_alert' => '0',
      'file_path' => 'Temp/',
      'servers' => 
      array (
        'Default' => 
        array (
          'memcached_test' => 
          array (
            'hostname' => 'memcached',
            'port' => '11211',
          ),
        ),
      ),
    );

