<?php

/** @var \Slim\App $app */

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;

use Exception;
use  App\Factory\FileFactory as FileFactory;
use  App\Factory\ImageFactory as ImageFactory;
use  App\Factory\FunctionFactory as FunctionFactory;

class UploadController extends BaseController
{
    public function uploadImages(Request $request, Response $response)
    {
        $imagesFactory = new ImageFactory;
        $fn = new FunctionFactory;
        try {
            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $this->validateRequiredFields(['images'], $_FILES);
            $this->validateRequiredFields(['pathName'], $_POST);

            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            $item = [];
            $files = $fn->reArrayFiles($_FILES['images']);

            $options = [
                "type" =>  isset($_POST['type']) ? $_POST['type'] : "webp",
                "quality" =>  isset($_POST['quality']) ? $_POST['quality'] : 80,
            ];

            $dirPath = $_ENV['STORAGE_PATH'] . "/" . $_POST['pathName'];

            foreach ($files as $key => $value) {
                $newName = date_timestamp_get(date_create()) * rand(2, 9);

                if (!is_dir($dirPath)) {
                    mkdir($dirPath);
                }

                $options['path'] =  $dirPath . "/" . $newName;
                $url = $imagesFactory->formatImage($value, $options);
                if (!$url) {
                    $this->addError('image', 'Error on upload image');
                    return $this->showErrors($response);
                }
                $aux = [
                    "name" => $newName,
                    "url" => $_POST['pathName'] . "/" . $newName . "." . $options['type']
                ];
                array_push($item, $aux);
            }
            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }

    public function uploadFiles(Request $request, Response $response)
    {
        $filesFactory = new FileFactory;
        $fn = new FunctionFactory;

        try {
            $parsed_body = $request->getParsedBody();


            if ($request->getAttribute('nivel') != User::PROFILE_ADMIN) {
                $this->addError('nivel', 'Esta ação não é permitida para este usuário');
                return $this->showErrors($response);
            }

            $this->validateRequiredFields(['page'], $parsed_body);
            if (count($this->errors) > 0) {
                return $this->errorResponse($response, $this->errors);
            }
            $files = $fn->reArrayFiles($_FILES['files']);
            $item = [];

            foreach ($files as $key => $value) {
                $aux = $filesFactory->uploadFile($value, $parsed_body['page']);
                if ($aux) {
                    $item[$key] = $aux;
                } else {
                    $this->addError('file', 'Upload Error');
                    return $this->errorResponse($response, $this->errors);
                }
            }
            return $this->responseOk($response, $item);
        } catch (Exception $e) {
            return $this->errorResponse($response, $this->errors, $e->getMessage());
        }
    }
}
