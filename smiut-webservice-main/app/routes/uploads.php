<?php
$baseURL = "/uploads";
$baseController = "UploadController";

$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("/images", ["\App\Controller\\".$baseController, 'uploadImages']);
    $app->post("/files", ["\App\Controller\\".$baseController, 'uploadFiles']);
})->add(function ($request, $response, $next) {
    return authorizationMiddleware($request, $response, $next);
});
