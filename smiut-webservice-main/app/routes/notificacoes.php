<?php
$baseURL = "/notificacoes";
$baseURLPublic = "/" . $_ENV['PROD_SULFIX'] . $baseURL;
$baseController = "NotificacoesController";

$app->group($baseURLPublic, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'readPublic']);
});
$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("/addPushToken", ["\App\Controller\\" . $baseController, 'addPushToken']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});