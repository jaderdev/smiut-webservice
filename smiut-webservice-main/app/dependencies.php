<?php
/**
 * @var \DI\Container $c
 */
use Illuminate\Database\Capsule\Manager as Capsule;


// $c->set(\Illuminate\Database\Connection::class, DI\factory(new \App\Factory\DatabaseFactory));
$c->set(\Monolog\Logger::class, DI\factory(new \App\Factory\MonologFactory));
