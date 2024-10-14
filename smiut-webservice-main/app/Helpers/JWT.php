<?php namespace App\Helpers;
use \Firebase\JWT\JWT as JWTFirebase;
class JWT 
{
    public static function Generate($data=[]) {
        $payload = array(
            "iat"     => time(),
            "exp"     => time() + (3600 * 24 * $_ENV['JWT_EXPIRATION_DAYS']),
        );

        foreach($data as $key=>$value) {
            $payload[$key] = $value;
        }
        return JWTFirebase::encode($payload, $_ENV['JWT_SECRET']);
    }

    public static function Decode($token) {
        return JWTFirebase::decode($token, $_ENV['JWT_SECRET'], array('HS256'));
    }
}
