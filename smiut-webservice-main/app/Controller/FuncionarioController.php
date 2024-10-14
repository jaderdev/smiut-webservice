<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\LogFactory as logs;

class FuncionarioController extends BaseController
{
    private $table = "empresas_funcionarios";

    public function create(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $logs = new logs;

            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $this->validateRequiredFields(['nome', 'password', 'username'], $parsed_body);
            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            if (isset($parsed_body['password'])) {
                $responsePassword = self::createPassword($parsed_body['password']);
                $parsed_body['password'] = $responsePassword['password'];
                $parsed_body['password_salt'] = $responsePassword['password_salt'];
            }

            if (!$parsed_body['id_empresa']) {
                $parsed_body['id_empresa'] = $request->getAttribute('id');
            }

            $item = $db->insert($this->table, $parsed_body);
            $logs->addLog($request->getAttribute('id'), $this->table, 'criacao', $item['id']);

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }


    public function read(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select f.*,e.primeiro_nome as empresa from " . $this->table . " f 
        left join empresas e on f.id_empresa = e.id";

        if ($request->getAttribute('super_administrador') == 0) {
            $query = $query . ' where id_empresa = ' . $request->getAttribute('id');
        }

        $items = $db->select($query);

        if (count($items) == 0) {
            return $this->responseOk($response, $items);
        }

        if (!$items) {
            return $this->notFound($response);
        }
        return $this->responseOk($response, $items);
    }

    public function readByEmpresaId(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if ($request->getAttribute('super_administrador') == 0) {
            $params['id'] = $request->getAttribute('id');
        }

        if (!isset($params['id'])) {
            $this->addError('id', 'You must send an id');
            return $this->showErrors($response);
        }

        $query = "select f.*,e.primeiro_nome as empresa from " . $this->table . " f 
        left join empresas e on f.id_empresa = e.id where f.id_empresa = " . $params['id'];

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
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if (!isset($params['id'])) {
            $this->addError('id', 'You must send an id');
            return $this->showErrors($response);
        }

        try {
            $query = "select * from  " . $this->table . " WHERE id = " . $params['id'];

            if ($request->getAttribute('super_administrador') == 0) {
                $query = $query . ' and id_empresa = ' . $request->getAttribute('id');
            }

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
        try {
            $db = new DB;
            $logs = new logs;

            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
            $params = $request->getAttribute('routeInfo')[2];

            if (!isset($params['id'])) {
                $this->addError('id', 'You must send an id');
                return $this->showErrors($response);
            }
            if (isset($parsed_body['password'])) {
                $responsePassword = self::createPassword($parsed_body['password']);
                $parsed_body['password'] = $responsePassword['password'];
                $parsed_body['password_salt'] = $responsePassword['password_salt'];
            }
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
        try {
            $db = new DB;
            $logs = new logs;

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
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

        $query = "select * from " . $this->table . "";
        $items = $db->select($query);

        if (count($items) == 0) {
            return $this->responseOk($response, $items);
        }

        if (!$items) {
            return $this->notFound($response);
        }


        return $this->responseOk($response, $items);
    }
    private static function createSalt()
    {
        $text = md5(uniqid(rand(), TRUE));
        return substr($text, 0, 3);
    }

    private static function createPassword($password)
    {
        $salt = self::createSalt();
        $hash = hash('sha256', $password);
        $aux = [
            "password" => hash('sha256', $salt . $hash),
            "password_salt" => $salt,
        ];

        return $aux;
    }
}
