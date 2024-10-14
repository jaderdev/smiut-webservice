<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;

class SettingsController extends BaseController
{
    private $table = "config";
    private $table_empresa = "config_empresa";
    private $table_api = "config_api";
    private $table_redes = "config_redes_sociais";

    public function create(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $fn = new Functions;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $this->validateRequiredFields(['nome'], $parsed_body);
            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            $parsed_body['url'] = $fn->sanitizeString($parsed_body['nome']);

            $item = $db->insert($this->table, $parsed_body);
            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }


    public function read(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from config where id = 1";
        $item = $db->select($query);

        if (count($item) == 0) {
            return $this->responseOk($response, $item);
        }

        return $this->responseOk($response, $item);
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
            $query = "select * from config c WHERE c.id = " . $params['id'];
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

    public function update(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
            $params = $request->getAttribute('routeInfo')[2];

            $item = $db->update($this->table, $parsed_body, 1);

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


    // MANUTENÇÃO

    public function readManutencao(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select manutencao,ips from " . $this->table_empresa . " where id = 1";
        $item = $db->select($query);

        if (count($item) == 0) {
            return $this->responseOk($response, $item);
        }

        return $this->responseOk($response, $item);
    }

    public function updateManutencao(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $item = $db->update($this->table_empresa, $parsed_body, 1);

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    // INFORMAÇÃO

    public function readInformacoes(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table_empresa . " where id = 1";
        $item = $db->select($query);

        if (count($item) == 0) {
            return $this->responseOk($response, $item);
        }

        return $this->responseOk($response, $item);
    }

    public function updateInformacoes(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
            $params = $request->getAttribute('routeInfo')[2];

            $item = $db->update($this->table_empresa, $parsed_body, 1);

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    // REDES SOCIAS

    public function readRedesSocias(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table_redes;
        $item = $db->select($query);

        if (count($item) == 0) {
            return $this->responseOk($response, $item);
        }

        return $this->responseOk($response, $item);
    }

    public function updateRedesSocias(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
            $params = $request->getAttribute('routeInfo')[2];
            foreach ($parsed_body as $value) {
                $db->update($this->table_redes, $value, $value['id']);
            }

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }

            return $this->responseOk($response);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function readApi(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table_api;
        $item = $db->select($query);

        if (count($item) == 0) {
            return $this->responseOk($response, $item);
        }

        return $this->responseOk($response, $item);
    }


    //API
    public function updateApi(Request $request, Response $response)
    {
        try {
            $db = new DB;
            $parsed_body = $request->getParsedBody();

            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }
            $params = $request->getAttribute('routeInfo')[2];
            foreach ($parsed_body as $value) {
                $db->update($this->table_api, $value, $value['id']);
            }

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }

            return $this->responseOk($response);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function getMyIP(Request $request, Response $response)
    {
        $final = $_SERVER['REMOTE_ADDR'];
        return $this->responseOk($response, $final);
    }

    // Public Routes

    public function verifyManutencao(Request $request, Response $response)
    {
        $db = new DB;

        $myIP =  $_SERVER['REMOTE_ADDR'];

        $query = "SELECT ips,manutencao FROM " . $this->table_empresa . " WHERE manutencao = 1";
        $final = $db->select($query)[0];

        $manutencao =  $final != null;
        if ($manutencao) {
            $ips = json_decode($final['ips']);
            $manutencao = !is_numeric(array_search($myIP, $ips));
        }
        return $this->responseOk($response, $manutencao);
    }

    public function readPublic(Request $request, Response $response)
    {
        $db = new DB;

        $query = "select * from " . $this->table;
        $config = $db->select($query);

        $query = "select * from " . $this->table_empresa;
        $empresa = $db->select($query);

        $query = "select nome,codigo,descricao from " . $this->table_api . " where visivel = 1";
        $api = $db->select($query);

        $query = "select nome,link,ref from " . $this->table_redes . " where visivel = 1";
        $redes_sociais = $db->select($query);

        $final = [
            "config" => $config[0],
            "empresa" => $empresa[0],
            "api" => $api,
            "redes_sociais" => $redes_sociais
        ];

        return $this->responseOk($response, $final);
    }
}
