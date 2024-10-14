<?php

/** @var \Slim\App $app */

use App\Helpers\JWT;

$app->get("/", ['\App\Controller\MainController', 'getHome']);

include_once("routes/auth.php");
include_once("routes/email.php");
include_once("routes/funcionarios.php");
include_once("routes/empresas.php");
include_once("routes/servicos.php");
include_once("routes/sensores.php");
include_once("routes/sensores-data.php");
include_once("routes/settings.php");
include_once("routes/uploads.php");
include_once("routes/users.php");

function authorizationMiddleware($request, $response, $next)
{
    //Authentication Middleware

    $authorization = $request->getHeaderLine('Authorization');
    // if not sended the Authorization
    if ($authorization == "") {
        return $response->withStatus(401);
    }
    // Teste if we have 2 parts of token
    // Bearer 9SAD0J21JASDÇASDK
    // Split 'Bearer' and '9SAD0J21JASDÇASDK'
    $authorizationParts = explode(" ", $authorization);
    if (count($authorizationParts) != 2) {
        return $response->withStatus(401);
    }

    // Get the JWT parte of the token. Eg. '9SAD0J21JASDÇASDK'
    $jwt = $authorizationParts[1];
    try {
        $decoded =  JWT::Decode($jwt);
        $decoded_array = (array) $decoded;

        // Pass values to request
        $request = $request->withAttribute('TOKEN_VALID', true);
        foreach ($decoded_array as $key => $value) {
            $request = $request->withAttribute($key, $value);
        }

        return $response = $next($request, $response);
    } catch (Exception  $e) {

        return  $response->withStatus(500)->withJson(['e' => $e->getMessage()]);
    }
}
