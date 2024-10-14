<?php
$baseURL = "/settings";
$baseURLPublic = "/" . $_ENV['PROD_SULFIX'] . $baseURL;
$baseController = "SettingsController";

$app->group($baseURLPublic, function () use ($app, $baseController) {
    $app->get("", ["\App\Controller\\" . $baseController, 'readPublic']);
    $app->get("/manutencao", ["\App\Controller\\" . $baseController, 'verifyManutencao']);
});

$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("/getMyIP", ["\App\Controller\\" . $baseController, 'getMyIP']);
});

$app->group($baseURL, function () use ($app, $baseController) {
    $app->get("/manutencao", ["\App\Controller\\" . $baseController, 'readManutencao']);
    $app->get("/informacoes", ["\App\Controller\\" . $baseController, 'readInformacoes']);
    $app->get("/redes_socias", ["\App\Controller\\" . $baseController, 'readRedesSocias']);
    $app->get("/api", ["\App\Controller\\" . $baseController, 'readApi']);
    $app->get("", ["\App\Controller\\" . $baseController, 'read']);
    $app->post("", ["\App\Controller\\" . $baseController, 'update']);
    $app->post("/manutencao", ["\App\Controller\\" . $baseController, 'updateManutencao']);
    $app->post("/informacoes", ["\App\Controller\\" . $baseController, 'updateInformacoes']);
    $app->post("/redes_socias", ["\App\Controller\\" . $baseController, 'updateRedesSocias']);
    $app->post("/api", ["\App\Controller\\" . $baseController, 'updateApi']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
