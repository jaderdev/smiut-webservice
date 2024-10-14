<?php

namespace App\Factory;

use PDO;
use Exception;

class DatabaseFactory
{
    protected $db;
    private $host, $username, $password, $database;

    public function __construct()
    {
        $this->host = $_ENV["DB_HOST"];
        $this->username = $_ENV["DB_USER"];
        $this->password = $_ENV["DB_PASS"];
        $this->database = $_ENV["DB_NAME"];
        $this->connect();
    }

    private function connect()
    {
        $this->db = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->database, $this->username, $this->password);
        $this->db->exec("SET NAMES 'utf8';");
        $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->db->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND, "SET NAMES 'utf8'");
    }

    public function select($query, $params = [])
    {
        try {
            $aux = $this->db->prepare($query);
            $aux->execute($params);
            return $aux->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return ["error" => $e];
        }
    }

    public  function insert($table, $params = [])
    {
        try {
            $keys = array_keys($params);
            $query = "INSERT INTO $table (" . implode(',', $keys) . ") VALUES (:" . implode(",:", $keys) . ")";

            $sth = $this->db->prepare($query);

            foreach ($params as $key => $value) {
                $sth->bindValue(':' . $key, $value);
            }
            $sth->execute();
            $params['id'] = $this->db->lastInsertId();
            return $params;
        } catch (Exception $e) {
            return ["error" => $e];
        }
    }

    public function update($table, $params = [], $id = 0, $fieldId = 'id')
    {
        try {
            foreach ($params as $key => $values) {
                $sets[] = $key . " = :" . $key;
            }
            $query = "UPDATE  $table SET " . implode(',', $sets) . " WHERE " . $fieldId . " = :id";
            $sth = $this->db->prepare($query);

            if ($id != 0 || (is_string($id) && strlen($id))) {
                $sth->bindValue(':id', $id);
            }

            foreach ($params as $key => $v) {
                $value = $params[$key];
                if (is_bool($value)) {
                    $value = $value ? 1 : 0;
                }
                $sth->bindValue(':' . $key, $value);
            }

            $sth->execute();

            return ["id" => $id];
        } catch (Exception $e) {
            return ["error" => $e];
        }
    }
    public  function delete($table, $param, $id)
    {
        try {
            $query = "delete from $table where $param in ($id)";
            $sth = $this->db->prepare($query);
            $sth->execute();
            return ["id" => $id];
        } catch (Exception $e) {
            return ["error" => $e];
        }
    }
    public function execute($query)
    {
        try {
            $aux = $this->db->prepare($query);
            $aux->execute();
            return $aux->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return ["error" => $e];
        }
    }
}
