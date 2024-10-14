<?php

namespace App\Factory;
use  App\Factory\DatabaseFactory as DB;

class ImageFactory
{
    public function createImage($imagem, $pathName, $fileName = null, $type = null)
    {
        $basePath =  $_ENV['STORAGE_PATH'] . "/";

        if ($imagem) {
            if (!isset($fileName)) {
                $fileName = rand();
            }
            if (!isset($type)) {
                $type = "webp";
            }

            $options = [
                "pathName" => $pathName,
                "fileName" => $fileName,
                "dirPath" => $basePath . $pathName,
                "fullPathName" => $basePath . $pathName . "/" . $fileName . "." . $type,
                "type" => $type,
            ];

            if (!is_dir($options['dirPath'])) {
                mkdir($options['dirPath']);
            }

            //Verificar se foi ok
            $responseImage = $this->formatImage($imagem, $options);
            return  $responseImage;
        }
    }

    public function imageToWebp($file, $options)
    {
        $basePath =  $_ENV['STORAGE_PATH'] . "/";
        try {
            if (isset($file['tmp_name'])) {
                $source = $file['tmp_name'];
            }
            if (isset($file['type'])) {
                switch ($file['type']) {
                    case "image/jpeg":
                        $image = imagecreatefromjpeg($source);
                        break;
                    case "image/gif":
                        $image = imagecreatefromgif($source);
                        break;
                    case "image/png":
                        $image = imagecreatefrompng($source);
                        imagealphablending($image, true);
                        break;
                }
            } else {
                $image = imagecreatefromstring($file);
            }

            $width = imagesx($image);
            $height = imagesy($image);
            $fullPathName = $options['path'] . ".webp";

            $newImage = imagecreatetruecolor($width, $height);
            imagecopy($newImage, $image, 0, 0, 0, 0, $width, $height);
            imagewebp($newImage, $fullPathName, $options['quality'] | 80);
            imagedestroy($image);
            imagedestroy($newImage);

            $fileName =  str_replace($basePath, "", $fullPathName);
            return $fileName;
        } catch (\Throwable $th) {
            return $th;
        }
    }
    public function formatImage($file, $options)
    {
        switch ($options['type']) {
            case "webp":
                $item = $this->imageToWebp($file, $options);
                break;
            default:
                break;
        }
        return $item;
    }
    public function updateImagesDb($id, $nome, $imagens,$relationName,$tableName)
    {
        $db = new DB;

        $toInsert =  $imagens['toInsert'];
        $toUpdate =  $imagens['toUpdate'];
        $toDelete =  $imagens['toDelete'];

        foreach ($toInsert as $key => $value) {
            $data = [
                $relationName => $id,
                "nome" => $value['fileName'],
                "alt" => $nome,
                "url" => $value['pathName'],
                "ordem" => 99,
                "visivel" => 1
            ];
            $responseDataImage = $db->insert($tableName, $data);
        }
        foreach ($toUpdate as $key => $value) {
            $data = [
                $relationName => $value['id'],
                "nome" => $value['nome'],
                "alt" => $value['alt'],
                "url" => $value['url'],
                "ordem" => $value['ordem'],
                "visivel" => $value['visivel']
            ];
            $responseDataImage = $db->update($tableName, $data);
        }
        if (count($toDelete) > 0) {
            $aux = implode(",", $imagens['toDelete']);
            $responseDataImage = $db->delete($tableName, "id", $aux);
        }
    }
}
