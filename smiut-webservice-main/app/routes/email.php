<?php

$baseURL = "/email";
$baseURLPublic = "/" . $_ENV['PROD_SULFIX'] . $baseURL;
$baseController = "EmailController";

$app->group($baseURLPublic, function () use ($app, $baseController) {
    //$app->post("/contact", ["\App\Controller\\".$baseController, 'contato']);
    $app->post("/{ref}", ["\App\Controller\\".$baseController, 'sendEmailWithDbData']);
});

$app->group($baseURL, function () use ($app, $baseController) {
    $app->post("", ["\App\Controller\\".$baseController, 'create']);
    $app->patch("/{id}", ["\App\Controller\\".$baseController, 'update']);
    $app->delete("/{id}", ["\App\Controller\\".$baseController, 'delete']);
});
