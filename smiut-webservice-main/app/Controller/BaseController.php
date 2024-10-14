<?php

namespace App\Controller;

use Exception;
use Slim\Http\Request;
use Slim\Http\Response;
use Slim\Http\UploadedFile;

class BaseController
{
    protected $errors = [];

    public function addError($field, $message = "")
    {
        $this->errors[] = ["field" => $field, "message" => $message];
    }
    public function hasErrors()
    {
        if (count($this->errors) > 0) {
            return true;
        }
        return false;
    }
    public function showErrors(Response $response)
    {
        return $this->errorResponse($response, $this->errors);
    }
    public function validateRequiredFields($fields, $parsed_body)
    {
        // $parsed_body = $request->getParsedBody();
        // print_r($parsed_body);
        foreach ($fields as $field) {
            try {
                $value = @$parsed_body[$field];
                if (!$value) {
                    $this->addError($field,  $field . " é obrigatório");
                }
            } catch (Exception $e) {
                $this->addError($field,  $field . " é obrigatório");
            }
        }
    }

    public function validateEmail($field, $parsed_body)
    {
        // $parsed_body = $request->getParsedBody();
        $value = @$parsed_body[$field];
        if (!filter_var($value, FILTER_VALIDATE_EMAIL)) {
            $this->addError($field,  $field . " é inválido");
        }
    }

    // recieve all fields to search by like
    // if the user sends the param this method will apply to the query
    public function searchByLike($fields, &$object)
    {
        foreach ($fields as $field) {
            if (isset($_GET[$field])) {
                $object->where($field, 'LIKE', '%' . $_GET[$field] . '%');
            }
        }
    }

    public function searchByEqual($fields, &$object)
    {
        foreach ($fields as $field) {
            if (isset($_GET[$field])) {
                $object->where([$field => $_GET[$field]]);
            }
        }
    }
    public function errorResponse(Response $response, $data = [], $message = 'Error to process request')
    {
        $message = $message == '' ? 'error' : $message;
        return $response
            ->withStatus(422)
            ->withHeader('Content-Type', 'application/json')
            ->withJson(['message' => $message, 'data' => $data]);
    }

    public function responseOk(Response $response, $data = [], $message = 'success')
    {
        return $response
            ->withStatus(200)
            ->withHeader('Content-Type', 'application/json')
            ->withJson(['message' => $message, 'data' => $data]);
    }

    public function notFound(Response $response)
    {
        return $response
            ->withStatus(404);
    }

    public function forbidden(Response $response)
    {
        return $response
            ->withStatus(403);
    }


    function moveUploadedFile($directory, UploadedFile $uploadedFile)
    {
        $extension = pathinfo(
            $uploadedFile->getClientFilename(),
            PATHINFO_EXTENSION
        );
        $basename = bin2hex(random_bytes(8));
        $filename = sprintf('%s.%0.8s', $basename, $extension);
        $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);

        return $filename;
    }


    public function staticPath($request)
    {
        return $request->getUri()->getBaseUrl() . '/' . $_ENV['STORAGE_PATH'];
    }
}
