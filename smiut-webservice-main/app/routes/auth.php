<?php
$baseURL = "/auth";
$baseController = "AuthController";

$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("/login", ["\App\Controller\\" . $baseController, 'login']);
    $app->get("/restricted", ["\App\Controller\\" . $baseController, 'restricted']);
});

$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("/token", ["\App\Controller\\" . $baseController, 'verifyToken']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
