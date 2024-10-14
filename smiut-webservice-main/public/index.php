<?php
const APP_ROOT = __DIR__ . "/..";

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Illuminate\Database\Capsule\Manager as Capsule;
use josegonzalez\Dotenv\Loader;

require '../vendor/autoload.php';
session_start();

$app = new \Slim\App;

//SET ENV
$Loader = new Loader('../.env');
$Loader->parse();
$Loader->toEnv();

/** @var \DI\Container $c */
$app = new class() extends \DI\Bridge\Slim\App
{
    protected function configureContainer(\DI\ContainerBuilder $builder)
    {
        $builder->addDefinitions([
            "settings.httpVersion" => "2.0",
            "settings.responseChunkSize" => 4096,
            "settings.outputBuffering" => "append",
            "settings.displayErrorDetails" => 1,
            "settings.determineRouteBeforeAppMiddleware" => true // must be true for error handling etc.
        ]);
    }
};
/** @var \DI\Container $c */
$c = $app->getContainer();

// Allow from any origin
if (isset($_SERVER['HTTP_ORIGIN'])) {
    // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
    // you want to allow, and if so:
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        // may also be using PUT, PATCH, HEAD etc
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS,DELETE");

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    exit(0);
}

require APP_ROOT . "/app/dependencies.php";
require APP_ROOT . "/app/routes.php";
require APP_ROOT . "/app/middleware.php";
$app->run();
