<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' =>
  array (
    0 =>
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 =>
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' =>
  array (
    'host' => 'redis-server',
    'password' => '',
    'port' => 6379,
  ),
  'passwordsalt' => 'Dmu/rxnuih3tsOGGAALWm1FO1ckEl2',
  'secret' => 'dVUsxQ7RsRuSf9a+oAjsTNE/PXjMhXEpeu/aRgL0aZotqcM8',
  'trusted_domains' =>
  array (
    0 => 'localhost',
    1 => 'nc.<DOMAIN>',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'pgsql',
  'version' => '21.0.0.18',
  'overwritehost' => 'nc.<DOMAIN>',
  'overwriteprotocol' => '<PROTOCOL>',
  'overwrite.cli.url' => '<PROTOCOL>://nc.<DOMAIN>',
  'dbname' => 'nextcloud',
  'dbhost' => 'pg-server',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'dbuser' => 'oc_webmaster',
  'dbpassword' => 'edyxm276yv4fjlj7k3sp0ttarcqbgw',
  'installed' => true,
  'instanceid' => 'ocx3gge30c1n',
);
