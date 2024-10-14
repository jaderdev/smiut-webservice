<?php

namespace App\Helpers;


class UrlHelper
{
    public static function isHttps()
    {
        return isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off';
    }

    public static function returnProtocol()
    {
        if(self::isHttps())
        {
            return "https://";
        }
        else
        {
            return "http://";
        }
    }

    public static function baseUrl()
    {
        if (php_sapi_name() == 'cli')
        {
            return '';
        }

        $pathinfo = pathinfo($_SERVER['SCRIPT_NAME']);
        $dirname = $pathinfo['dirname'];

        return static::returnProtocol().
            $_SERVER['HTTP_HOST'].
            (($dirname != DIRECTORY_SEPARATOR) ? $dirname."/" : "/");
    }
}