<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;
use  App\Factory\LogFactory as logs;

class NotificacaoController extends BaseController
{
    private $table = "empresas";

    public function addPushToken(Request $request, Response $response)
    {

       /*  if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
            return $this->showErrors($response);
        } */

        try {
            $db = new DB;
            $fn = new Functions;
            $logs = new logs;

            $parsed_body = $request->getParsedBody();

            $this->validateRequiredFields(['primeiro_nome', 'telefone', 'username'], $parsed_body);
            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            if (isset($parsed_body['password'])) {
                $responsePassword =  $fn->createPassword($parsed_body['password']);
                $parsed_body['password'] = $responsePassword['password'];
                $parsed_body['password_salt'] = $responsePassword['password_salt'];
            }

            $parsed_body['username'] = $parsed_body['username'];
            $parsed_body['slug'] = $fn->sanitizeString($parsed_body['primeiro_nome']);

            $item = $db->insert($this->table, $parsed_body);
            $logs->addLog($request->getAttribute('id'), $this->table, 'criacao', $item['id']);

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }
}
