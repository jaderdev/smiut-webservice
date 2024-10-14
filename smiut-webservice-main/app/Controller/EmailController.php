<?php

use Slim\App;

/** @var App $app */

namespace App\Controller;

use App\Exception\BadRequestException;
use App\Exception\RuntimeException;
use App\Service\MailContentService;
use App\Service\MailService;
use Slim\Http\Request;
use Slim\Http\Response;
use Exception;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;

class EmailController extends BaseController
{
    /**
     * @param Request $request
     * @param Response $response
     * @throws BadRequestException
     * @throws RuntimeException
     */
    public function sendEmailWithDbData(Request $request, Response $response)
    {
        $db = new DB;
        $fn = new Functions;
        $data = $request->getParsedBody();
        $params = $request->getAttribute('routeInfo')[2];

        $form_ref =  $params['ref'];

        try {
            $query = "SELECT * FROM l_notificacoes_pt WHERE ref = '" . $form_ref . "'";
            $items = $db->select($query);
            if (count($items) == 1) {
                $items = $items[0];

                $fields = json_decode($items['tags']);
                $items['assunto_cliente'] = $fn->replaceStringWithJson($items['assunto_cliente'], $fields, $data);
                $items['assunto_admin'] = $fn->replaceStringWithJson($items['assunto_admin'], $fields, $data);
                $items['descricao_admin'] = $fn->replaceStringWithJson($items['descricao_admin'], $fields, $data);
                $items['descricao_cliente'] = $fn->replaceStringWithJson($items['descricao_cliente'], $fields, $data);
            } else {
                return $this->notFound($response);
            }

            //Send Email to Client
            $mail = new MailService($data['email']);
            $mail->send($items['assunto_cliente'],  $items['descricao_cliente']);

            //Send Email to Admin
            $mailAdmin = new MailService($items['email']);
            $mailAdmin->send($items['assunto_admin'],  $items['descricao_admin']);

            return $this->responseOk($response, true);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function contato(Request $request, Response $response)
    {
        $body = [
            "nome" => $_POST['name'],
            "titulo" => $_POST['title'],
            [
                "name" => "Mensagem",
                "value" => $_POST['message'],
            ]
        ];
        $files = [
            'arquivo' => $_FILES['file']
        ];
        $mail = new MailService($_POST['email']);
        return $this->responseOk($response, $mail->send('Contact mail', new MailContentService($body, $files)));
    }


    public function newsletter(Request $request, Response $response)
    {
        $files = [];
        $title =  $_POST['title'];

        $body = [
            "email" => $_POST['email'],
            [
                "name" => "Mensagem",
                "value" => $_POST['message'],
            ]
        ];
        $mail = new MailService($_POST['email']);
        return $this->responseOk($response, $mail->send($title, new MailContentService($body)));
    }
}
