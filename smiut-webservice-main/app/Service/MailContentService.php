<?php

namespace App\Service;

use App\Factory\FileFactory;
use App\Helpers\StringHelper;
use App\Helpers\UrlHelper;
use  App\Factory\DatabaseFactory as DB;
use  App\Factory\FunctionFactory as Functions;

class MailContentService
{
    private $fields;
    private $files;

    public function __construct($fields = [], $files = [])
    {
        $this->fields = $fields;
        $this->files = $files;
    }
    public function format($body, $subject)
    {
        $db = new DB;
        $fn = new Functions;

        $query = "SELECT nome,url,cor_base,logo from config_empresa ";
        $items = $db->select($query);
        $items = $items[0];
        $items['assunto'] = $subject;
        $changeFields = [
            ["ref" => "logo", "tag" => "#empresa_logo#"],
            ["ref" => "assunto", "tag" => "#assunto#"],
            ["ref" => "nome", "tag" => "#empresa_nome#"],
            ["ref" => "url", "tag" => "#empresa_url#"],
            ["ref" => "cor_base", "tag" => "#empresa_cor#"],
        ];
        $auxChangeFields = json_decode(json_encode($changeFields));
        $body = $fn->replaceStringWithJson($body, $auxChangeFields, $items);
        $body = $this->setSocialNetworks($body);

        return $body;
    }

    public function setSocialNetworks($body)
    {
        $db = new DB;

        $query = "SELECT nome,link,icone from config_redes_sociais where visivel =1 order by ordem";
        $items = $db->select($query);
        $socialNetworks = "";
        foreach ($items as $key => $value) {
            $socialNetworks .= '
            <li style="display: inline-block;margin-left: 8px;">
                <a href="'.$value['link'].'">
                    <img src="' . $value['icone'] .'" width="26" height="26"
                        alt="' . $value['nome'] .'" style="display:block">
                </a>
            </li>';
        }

        return str_replace("#empresa_redes_sociais#",$socialNetworks,$body);
    }

    public function render()
    {
        $html = '';

        foreach ($this->fields as $key => $field) {
            if (is_array($field)) {
                $html .= '<p><b>' . $field['name'] . ':</b> ' . $field['value'] . '</p>';
            } else {
                $name = StringHelper::keyToName($key);
                $html .= '<p><b>' . $name . ':</b> ' . $field . '</p>';
            }
        }

        $fileFactory = new FileFactory();
        foreach ($this->files as $key => $file) {
            $fileInfo = $fileFactory->uploadFile($file, 'email');
            $filePath = UrlHelper::baseUrl() . 'storage/' . $fileInfo['pathName'];

            $name = StringHelper::keyToName($key);
            $html .= '<p><b>' . $name . ':</b> [<a href="' . $filePath . '">File</a>]</p>';
        }

        return $html;
    }
}
