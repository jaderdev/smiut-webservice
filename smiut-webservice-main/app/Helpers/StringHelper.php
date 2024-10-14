<?php

namespace App\Helpers;

class StringHelper
{
    public static function keyToName($string, $delimiter = "_")
    {
        $string = strtolower($string);
        while(strpos($string, $delimiter) !== false)
        {
            $pos = strpos($string, $delimiter, 0);
            $string = substr($string, 0, $pos).substr($string, $pos + 1)." ";
        }

        return ucfirst(trim($string));
    }
}