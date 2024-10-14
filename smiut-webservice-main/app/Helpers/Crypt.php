<?php namespace App\Helpers;
class Crypt 
{
    public static function Generate($data) {
       return SHA1(MD5($data.$_ENV['PASSWORD_HASH']));
    }

 
}
