# PHPMemcachedAdmin #

### Graphic stand-alone administration for memcached to monitor and debug purpose ###

This program allows to see in **real-time** (top-like) or from the start of the server, **stats for get, set, delete, increment, decrement, evictions, reclaimed, cas command**, as well as **server stats** (network, items, server version) with googlecharts and  **server internal configuration**

You can go further to **see each server slabs, occupation, memory wasted and items** (**key & value**).

Another part can execute commands to any memcached server : get, set, delete, flush\_all, as well as execute any commands (like stats) with telnet

## Feature list ##

<h4>Statistics</h4>
<ul><li>Stats for each or all memcached servers, items, evicted, reclaimed ...<br>
</li><li>Stats for every command : set, get, delete, incr, decr, cas ...<br>
</li><li>Slabs stats (Memory, pages, memory wasted, items)<br>
</li><li>Items stats (View items in slabs, then data for each key)<br>
</li><li>Network stats (Traffic, bandwidth)</li></ul>

<h4>Commands</h4>
<ul><li>Execute commands : get, set, delete, flush_all on servers to administrate or debug it<br>
</li><li>Get data with key on servers<br>
</li><li>Delete keys on servers<br>
</li><li>Flush servers<br>
</li><li>Execute telnet command directly from phpMemcachedAdmin<br>
</li><li>Search for specific pattern into all keys</li></ul>

<h4>Live Stats</h4>
<ul><li>Top-like real time stats with configurable alerts</li></ul>


<h4>Configuration</h4>
<ul><li>Edit configuration directly from web page<br>
</li><li>phpMemcachedAdmin can use socket communication, PECL Memcache or Memcached API<br>
</li><li>Organize your servers into cluster</li></ul>

## Security ##

phpMemcachedAdmin does not provide any security system, you need to add this feature by yourself.

## Installation ##

Download latest release
Unzip/Untar & Give files permissions

You have to give **Read & Execute right to all files**, and **Read, Write & Execute to configuration files and temporary directory**.

More information in https://blog.elijaa.org/phpmemcachedadmin-installation-guide/