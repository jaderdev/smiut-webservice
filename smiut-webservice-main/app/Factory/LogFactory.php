<?php

namespace App\Factory;
use  App\Factory\DatabaseFactory as DB;

class LogFactory
{
    private $table = "logs";

    public function addLog($id_user,$screen,$function,$id_item = 0)
    {
        $db = new DB;

        $data = [
            'funcao'=> $function,
            'pagina'=> $screen,
            'id_user'=> $id_user,
            'id_item'=> $id_item,
            'date'=> date('Y-m-d h:i:s')
        ];
        $responseLog = $db->insert($this->table, $data);
        return $responseLog;
    }
}
