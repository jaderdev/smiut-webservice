<?php
$baseURL = "/config/imagens";
$baseTiposURL = "/config/imagens-tipos";
$baseController = "ImagensController";
$tiposImagensController = "ImagensTiposController";

$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'read']);
    $app->get("/{id}", ["\App\Controller\\" . $baseController, 'readID']);
});
$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("", ["\App\Controller\\" . $baseController, 'create']);
    $app->post("/{id}", ["\App\Controller\\" . $baseController, 'update']);
    $app->post("/toBase64/", ["\App\Controller\\" . $baseController, 'toBase64']);
    $app->delete("/{id}", ["\App\Controller\\" . $baseController, 'delete']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});

$app->group($baseTiposURL, function () use ($app, $tiposImagensController) {
    $app->get("", ["\App\Controller\\" . $tiposImagensController, 'read']);
    $app->get("/lista/{id}", ["\App\Controller\\" . $tiposImagensController, 'readByTypeID']);
    $app->get("/{id}", ["\App\Controller\\" . $tiposImagensController, 'readID']);
});
$app->group($baseTiposURL, function () use ($app, $tiposImagensController) {
    $app->post("", ["\App\Controller\\" . $tiposImagensController, 'create']);
    $app->post("/{id}", ["\App\Controller\\" . $tiposImagensController, 'update']);
    $app->delete("/{id}", ["\App\Controller\\" . $tiposImagensController, 'delete']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
