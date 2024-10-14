<?php

namespace App\Factory;

class FileFactory
{
    public function uploadFile($file, $pathName, $fileName = null)
    {
        $basePath =  $_ENV['STORAGE_PATH'] . "/";

        if (!isset($fileName)) {
            $fileName = rand();
        }
        $ext = pathinfo($file['name'], PATHINFO_EXTENSION);

        $options = [
            "fileName" => $fileName.".". $ext,
            "dirPath" => $basePath . $pathName,
            "pathName" => $pathName . "/" . $fileName . "." . $ext,
            "fullPathName" => $basePath . $pathName . "/" . $fileName . "." . $ext,
        ];

        if (copy($file['tmp_name'], $options['fullPathName'])) {
            return $options;
        } else {
            echo "Sorry, there was an error uploading your file.";
            return false;
        }

        //$response = file_put_contents($options['fullPathName'], $data);
    }
}
