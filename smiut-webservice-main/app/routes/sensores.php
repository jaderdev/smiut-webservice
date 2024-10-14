<?php
$baseURL = "/sensores";
$baseURLPublic = "/" . $_ENV['PROD_SULFIX'] . $baseURL;
$baseController = "SensorController";

$app->group($baseURLPublic, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'readPublic']);
});
$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'read']);
    $app->get("/{id}", ["\App\Controller\\" . $baseController, 'readID']);
    $app->post("", ["\App\Controller\\" . $baseController, 'create']);
    $app->post("/{id}", ["\App\Controller\\" . $baseController, 'update']);
    $app->delete("/{id}", ["\App\Controller\\" . $baseController, 'delete']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});