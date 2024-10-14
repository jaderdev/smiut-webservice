<?php

/** @var \Slim\App $app */

$app->add($c->make(\App\Middleware\ExceptionHandlingMiddleware::class));
