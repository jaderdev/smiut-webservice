<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;
use \App\Helpers\JWT;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;
use  App\Factory\ImageFactory as ImageFactory;

class UserController extends BaseController
{
    private $table = "empresas";

    public function create(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $fn = new Functions;
            $imageFactory = new ImageFactory;

            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $this->validateRequiredFields(['nome'], $parsed_body);
            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }

            if (isset($parsed_body['password'])) {
                $responsePassword = self::createPassword($parsed_body['password']);
                $parsed_body['password'] = $responsePassword['password'];
                $parsed_body['password_salt'] = $responsePassword['password_salt'];
            }

            $item = $db->insert($this->table, $parsed_body);
            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }


    public function read(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table;
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
            $item = $db->select($query);

            if (count($item) == 0) {
                return $this->responseOk($response, $item);
            }
            if (!$item) {
                return $this->notFound($response);
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function verifyPassword(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $fn = new Functions;

            $parsed_body = $request->getParsedBody();
            $params = $request->getAttribute('routeInfo')[2];


            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                throw new Exception();
            }

            $id = $params['id'];

            $query = "select * from  " . $this->table . " WHERE id = " . $id;
            $item = $db->select($query)[0];

            $password = hash("sha256", $parsed_body['password']); //encriptar password inserida

            $password_db = $item['password'];
            $password_salt_db = $item['password_salt'];

            $password_final = hash("sha256", $password_salt_db . $password); //aplica salt a  password inserida

            if ($password_final != $password_db) {
                $this->addError('username', 'usuário inválido');
                $this->addError('password', 'password inválido');
                throw new Exception();
            }

            return $this->responseOk($response, true);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function update(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $imageFactory = new ImageFactory;
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

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function delete(Request $request, Response $response)
    {
        try {
            $db = new DB;

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

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }
    public function userAtual(Request $request, Response $response)
    {
        $db = new DB;

        try {
            $id = $request->getAttribute('username');

            if ($id) {
                $query = '
                select * from (
                    SELECT e.id,e.username,e.password,e.password_salt,e.ativo,e.slug from empresas e
                    where !isnull(e.slug)
                    union all
                    select ef.id,ef.username,ef.password,ef.password_salt,ef.ativo,e.slug  from empresas_funcionarios ef 
                    inner join empresas e on ef.id_empresa = e.id 
                    where !isnull(e.slug) and !isnull(ef.password)
                )a where a.username = "' . $id . '" ';

                $user = $db->select($query);
                if (count($user) > 0) {
                    $user = $user[0];

                    $user['token'] = JWT::Generate(
                        [
                            'id' => $user['id'],
                            'nome' => $user['nome'],
                            'slug' => $user['slug'],
                            'username' => $user['username'],
                            'nivel' => 2,
                        ]
                    );

                    return $this->responseOk($response, $user);
                }
            }

            $this->addError('user', "Token inválido");

            if ($this->hasErrors()) {
                return $this->showErrors($response);
            }
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
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
