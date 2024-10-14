<?php
$baseURL = "/users";
$baseController = "UserController";

$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'read']);
    $app->get("/atual", ["\App\Controller\\" . $baseController, 'userAtual']);
    $app->get("/{id}", ["\App\Controller\\" . $baseController, 'readID']);
    $app->post("", ["\App\Controller\\" . $baseController, 'create']);
    $app->post("/{id}/password", ["\App\Controller\\" . $baseController, 'verifyPassword']);
    $app->post("/{id}", ["\App\Controller\\" . $baseController, 'update']);
    $app->delete("/{id}", ["\App\Controller\\" . $baseController, 'delete']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
