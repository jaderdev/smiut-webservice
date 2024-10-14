<?php

namespace App\Factory;

class FunctionFactory
{
    public function sanitizeString($str)
    {
        $str = preg_replace('/[áàãâä]/ui', 'a', $str);
        $str = preg_replace('/[éèêë]/ui', 'e', $str);
        $str = preg_replace('/[íìîï]/ui', 'i', $str);
        $str = preg_replace('/[óòõôö]/ui', 'o', $str);
        $str = preg_replace('/[úùûü]/ui', 'u', $str);
        $str = preg_replace('/[ç]/ui', 'c', $str);
        //$str = preg_replace('/[,(),;:|!"#$%&/=?~^><ªº-]/', '_', $str);
        $str = preg_replace('/[^a-z0-9]/i', '_', $str);
        $str = preg_replace('/_+/', '_', $str);
        $str = strtolower($str);
        return $str;
    }

    function reArrayFiles(&$file_post)
    {
        $file_ary = array();
        $file_count = count($file_post['name']);
        $file_keys = array_keys($file_post);

        for ($i = 0; $i < $file_count; $i++) {
            foreach ($file_keys as $key) {
                $file_ary[$i][$key] = $file_post[$key][$i];
            }
        }

        return $file_ary;
    }

    public function replaceStringWithJson($stringToReplace, $fields, $data)
    {
        $aux = $stringToReplace;
        foreach ($fields as $key => $value) {
            $tag = $value->tag;
            $ref = $value->ref;
            $aux = str_ireplace($tag, $data[$ref], $aux);
        }
        return $aux;
    }
    public static function createSalt()
    {
        $text = md5(uniqid(rand(), TRUE));
        return substr($text, 0, 3);
    }

    public static function createPassword($password)
    {
        $salt = self::createSalt();
        $hash = hash('sha256', $password);
        $aux = [
            "password" => hash('sha256', $salt . $hash),
            "password_salt" => $salt,
        ];

        return $aux;
    }
}
