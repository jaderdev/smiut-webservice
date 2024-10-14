<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;

use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\LogFactory as logs;

class SensorDataController extends BaseController
{
    private $table = "sensores_data";

    public function createPublic(Request $request, Response $response)
    {
        try {
            $db = new DB;

            $parsed_body = $request->getParsedBody();

            if ($parsed_body['access_token'] != $_ENV['ACCESS_TOKEN_SYSTEM']) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $insertSQL = 'insert into sensores_data (deviceid,valor_umidade,valor_temperatura,date) values';
            $sqlAux = '';
            $data = $parsed_body['data'];
            foreach ($data as $key => $value) {
                $sqlAux = $sqlAux . "('"
                    . $value['deviceid'] . "','"
                    . $value['valor_umidade'] . "','"
                    . $value['valor_temperatura'] . "','"
                    . $value['date']
                    . "'),";
            }
            $sqlAux = rtrim($sqlAux, ",");
            $insertSQL = $insertSQL . $sqlAux;

            $item = $db->execute($insertSQL);

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

    public function readLastValuesByDeviceId(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];
        $parsed_body = $request->getParsedBody();

        if (!isset($params['deviceid'])) {
            $this->addError('deviceid', 'You must send an deviceid');
            return $this->showErrors($response);
        }

        try {
            $limit = $parsed_body['limit'] ?? 10;

            $deviceid = $params['deviceid'];

            $query = "select s.nome,sd.id,sd.valor_umidade,sd.valor_temperatura,sd.data,e.slug,sd.deviceid from sensores_data sd 
            inner join sensores s on s.deviceid = sd.deviceid
            inner join empresas e on s.id_empresa = e.id
            where sd.deviceid = '" . $deviceid . "' order by sd.id desc limit " .  $limit;

            $item = $db->select($query);

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function readRangeLimitBySlug(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if (!isset($params['slug'])) {
            $this->addError('slug', 'You must send an slug');
            return $this->showErrors($response);
        }

        try {
            $slug = $params['slug'];

            $query = "select s.deviceid,
            ifnull(s.temp_maior_igual,0)temp_maior_igual,
            ifnull(s.temp_menor_igual,0)temp_menor_igual,
            ifnull(s.umid_maior_igual,0)umid_maior_igual,
            ifnull(s.umid_menor_igual,0)umid_menor_igual 
            from sensores s
            right join empresas e on s.id_empresa = e.id
            where s.ativo = 1 and e.slug = '" . $slug . "'";

            $item = $db->select($query);

            if (!$item) {
                return [];
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }
    public function readRangeLimitByDeviceId(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if (!isset($params['deviceid'])) {
            $this->addError('deviceid', 'You must send an deviceid');
            return $this->showErrors($response);
        }

        try {
            $deviceid = $params['deviceid'];

            $query = "select s.nome,s.temp_maior_igual ,s.temp_menor_igual,s.deviceid,
            s.umid_maior_igual,s.umid_menor_igual
            from sensores s where s.deviceid = '" . $deviceid . "'";

            $item = $db->select($query);

            if (!$item) {
                return [];
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function readValuesBySlug(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if (!isset($params['slug'])) {
            $this->addError('slug', 'You must send an slug');
            return $this->showErrors($response);
        }

        try {
            $slug = $params['slug'];

            $query = "
                select sd2.*,a.nome from (
                    select max(sd.id)id,s.nome from sensores_data sd
                    inner join sensores s on sd.deviceid  = s.deviceid 
                    inner join empresas e on s.id_empresa = e.id
                    where e.slug  = '" . $slug . "' group by sd.deviceid,s.nome
                )a
                left join sensores_data sd2 on sd2.id  =a.id";

            $item = $db->select($query);

            if (!$item) {
                return [];
            }

            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function readValuesByEmpresaId(Request $request, Response $response)
    {
        $db = new DB;
        $params = $request->getAttribute('routeInfo')[2];

        if (!isset($params['id'])) {
            $this->addError('id', 'You must send an id');
            return $this->showErrors($response);
        }

        try {
            $id = $params['id'];

            $query = "
                select sd2.*,a.id_sensor,a.nome,a.ativo,a.slug,
                a.temp_maior_igual,a.temp_menor_igual,
                a.umid_maior_igual,a.umid_menor_igual
                from (
                    select max(sd.id)id,s.nome,s.ativo,e.slug,
                    s.temp_maior_igual,s.temp_menor_igual,
                    s.umid_maior_igual,s.umid_menor_igual,s.id as id_sensor
                     from sensores_data sd
                    inner join sensores s on sd.deviceid  = s.deviceid 
                    inner join empresas e on s.id_empresa = e.id
                    where e.id  = '" . $id . "' 
                    group by sd.deviceid,s.nome,s.ativo,e.slug,
                    s.temp_maior_igual,s.temp_menor_igual,
                    s.umid_maior_igual,s.umid_menor_igual
                )a
                left join sensores_data sd2 on sd2.id  =a.id";

            $item = $db->select($query);

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

        $query = "select deviceid from " . $this->table;
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
