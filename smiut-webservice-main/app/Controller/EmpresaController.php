<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;
use  App\Factory\LogFactory as logs;

class EmpresaController extends BaseController
{
    private $table = "empresas";

    public function create(Request $request, Response $response)
    {

        if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
            return $this->showErrors($response);
        }

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


    public function read(Request $request, Response $response)
    {
        if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
//            return $this->showErrors($response);
            return $this->responseOk($response, []);
        }

        $db = new DB;

        $query = "select * from " . $this->table . ' where id <> 1 ';
        $items = $db->select($query);

        if (count($items) == 0) {
            return $this->responseOk($response, $items);
        }

        if (!$items) {
            return $this->notFound($response);
        }
        return $this->responseOk($response, $items);
    }

    public function readID(Request $request, Response $response)
    {
        if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
            return $this->showErrors($response);
        }

        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];


        if (!isset($params['id'])) {
            $this->addError('id', 'You must send an id');
            return $this->showErrors($response);
        }

        try {
            $query = "select * from  " . $this->table . " WHERE id <> 1 and id = " . $params['id'];
            $item = $db->select($query);

            if (count($item) == 0) {
                return $this->responseOk($response, $item);
            }
            if (!$item) {
                return $this->notFound($response);
            }
            $item = $item[0];

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function update(Request $request, Response $response)
    {
        if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
            return $this->showErrors($response);
        }

        try {
            $db = new DB;
            $fn = new Functions;
            $logs = new logs;

            $parsed_body = $request->getParsedBody();

            $params = $request->getAttribute('routeInfo')[2];

            if (!isset($params['id'])) {
                $this->addError('id', 'You must send an id');
                return $this->showErrors($response);
            }
            if (isset($parsed_body['password'])) {
                $responsePassword = $fn->createPassword($parsed_body['password']);
                $parsed_body['password'] = $responsePassword['password'];
                $parsed_body['password_salt'] = $responsePassword['password_salt'];
            }

            $parsed_body['username'] = $parsed_body['username'];
            $parsed_body['slug'] = $fn->sanitizeString($parsed_body['primeiro_nome']);

            $item = $db->update($this->table, $parsed_body, $params['id']);

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            $logs->addLog($request->getAttribute('id'), $this->table, 'edicao', $params['id']);

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function delete(Request $request, Response $response)
    {
        if ($request->getAttribute('super_administrador') == 0) {
            $this->addError('nivel', 'Apenas o administrador pode realizar esta ação');
            return $this->showErrors($response);
        }

        try {
            $db = new DB;
            $logs = new logs;

            $params = $request->getAttribute('routeInfo')[2];

            if (!isset($params['id'])) {
                $this->addError('id', 'You must send an id');
                return $this->showErrors($response);
            }

            $item = $db->delete($this->table, "id", $params['id']);
            $logs->addLog($request->getAttribute('id'), $this->table, 'apagar', $params['id']);

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function readPublic(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table . " where id <> 1";
        $items = $db->select($query);

        if (count($items) == 0) {
            return $this->responseOk($response, $items);
        }

        if (!$items) {
            return $this->notFound($response);
        }
        return $this->responseOk($response, $items);
    }
}
