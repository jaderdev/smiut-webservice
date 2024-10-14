<?php
$baseURL = "/sensores-data";
$baseURLPublic = "/" . $_ENV['PROD_SULFIX'] . $baseURL;
$baseController = "SensorDataController";

$app->group($baseURLPublic, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'readPublic']);
    $app->post("", ["\App\Controller\\" . $baseController, 'createPublic']);
});
$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'read']);
    $app->get("/rangeLimitBySlug/{slug}", ["\App\Controller\\" . $baseController, 'readRangeLimitBySlug']);
    $app->get("/bySlug/{slug}", ["\App\Controller\\" . $baseController, 'readValuesBySlug']);
    $app->get("/byEmpresaId/{id}", ["\App\Controller\\" . $baseController, 'readValuesByEmpresaId']);
    $app->post("/lastValues/{deviceid}", ["\App\Controller\\" . $baseController, 'readLastValuesByDeviceId']);
    $app->get("/rangeLimitByDeviceId/{deviceid}", ["\App\Controller\\" . $baseController, 'readRangeLimitByDeviceId']);
    $app->get("/{id}", ["\App\Controller\\" . $baseController, 'readID']);
    $app->post("", ["\App\Controller\\" . $baseController, 'create']);
    $app->post("/{id}", ["\App\Controller\\" . $baseController, 'update']);
    $app->delete("/{id}", ["\App\Controller\\" . $baseController, 'delete']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
