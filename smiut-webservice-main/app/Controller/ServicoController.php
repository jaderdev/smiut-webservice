<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;
use  App\Factory\ImageFactory as ImageFactory;

class ServicoController extends BaseController
{
    private $table = "l_servicos_pt";
    private $tableImages = "l_servicos_imagens";

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
            if ($item)
                return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function read(Request $request, Response $response)
    {
        $db = new DB;
        $query = "select * from ". $this->table;

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
            $query = "select * from " . $this->table . " c WHERE c.id = " . $params['id'];
            $item = $db->select($query);

            if (!$item) {
                return $this->notFound($response);
            }
            $item = $item[0];

            $query = "select * from " . $this->tableImages . " c WHERE c.id_projetos = " . $params['id'];
            $images = $db->select($query);

            $item['imagens'] = $images;

            return $this->responseOk($response, $item);
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

            /* Upload Imagens */
            if (isset($parsed_body['imagens'])) {
                $imageFactory->updateImagesDb($params['id'], $parsed_body['nome'], $parsed_body['imagens'], "id_projetos", $this->tableImages);
            }
            $parsed_body = \array_diff_key($parsed_body, ["imagens" => "xy"]);
            /* Upload Imagens */

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

    public function readPublic(Request $request, Response $response)
    {
        $db = new DB;
        $query = "select * from ". $this->table;

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
