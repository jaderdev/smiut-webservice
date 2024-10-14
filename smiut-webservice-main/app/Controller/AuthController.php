<?php

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Helpers\JWT;
use  App\Factory\DatabaseFactory as DB;
use Exception;

class AuthController extends BaseController
{
    // perform login by username and password
    public function login(Request $request, Response $response)
    {
        $db = new DB;
        try {
            $parsed_body = $request->getParsedBody();

            $this->validateRequiredFields(['username', 'password'], $parsed_body);
            if ($this->hasErrors()) {
                return $this->showErrors($response);
            }

            $query = "select * from empresas where username = '" . $parsed_body['username'] . "'";

            if (isset($parsed_body['isApp'])) {
                $query = '
                select * from (
                    select ef.id,ef.username,ef.password,ef.password_salt,ef.ativo,e.slug  from empresas_funcionarios ef 
                    inner join empresas e on ef.id_empresa = e.id 
                    where !isnull(e.slug) and !isnull(ef.password)
                )a where a.username = "' . $parsed_body['username'] . '" ';
            }

            $user = $db->select($query)[0];

            if (!$user) {
                $this->addError('user', "Usuário não existe");
            } else if ($user['ativo'] == 0) {
                $this->addError('user', "Usuário não está ativo");
            } else {
                $password = hash("sha256", $parsed_body['password']); //encriptar password inserida

                $password_db = $user['password'];
                $password_salt_db = $user['password_salt'];

                $password_final = hash("sha256", $password_salt_db . $password); //aplica salt a  password inserida

                if ($password_final != $password_db) {
                    $this->addError('password', 'Palavra-passe incorreta');
                }
            }

            if ($this->hasErrors()) {
                return $this->showErrors($response);
            }

            $user['token'] = JWT::Generate(
                [
                    'id' => $user['id'],
                    'nome' => $user['nome'],
                    'slug' => $user['slug'],
                    'username' => $user['username'],
                    'super_administrador' => $user['super_administrador'],
                    'nivel' => $user['super_administrador'] == 1 ? 1 : 2,
                ]
            );
            return $this->responseOk($response, $user);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function verifyToken(Request $request, Response $response)
    {
        $db = new DB;

        try {
            $username = $request->getAttribute('username');

            if ($username) {
                $query = "
                select * from (
                    SELECT e.id,e.username,e.primeiro_nome,e.password,
                    e.password_salt,e.ativo,e.slug,e.super_administrador from empresas e
                    where !isnull(e.slug)
                    union all
                    select ef.id,ef.username,ef.nome,ef.password,ef.password_salt,ef.ativo,e.slug,0  from empresas_funcionarios ef 
                    inner join empresas e on ef.id_empresa = e.id 
                    where !isnull(e.slug) and !isnull(ef.password)
                )a where a.username = '" . $username . "'";

                $item = $db->select($query);
                if (count($item) > 0) {
                    return $this->responseOk($response, $item[0]);
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
    // Tests if you are logged or not
    public function restricted(Request $request, Response $response)
    {
        if ($request->getAttribute('TOKEN_VALID')) {
            return $response->write('You are logged and your token wil expires at ' . $request->getAttribute('exp'));
        }
        return $response->write('You are not logged!');
    }
}
