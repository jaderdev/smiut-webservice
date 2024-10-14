<?php

namespace App\Controller;

use Slim\Http\Request;
use Slim\Http\Response;
use \App\Model\User;
use Illuminate\Database\Capsule\Manager as Capsule;
use \App\Helpers\JWT;
use  App\Factory\DatabaseFactory as DB;

class MainController extends BaseController
{

    public function getHome(Request $request, Response $response)
    {

        // User::
        return $response->write("API " . $_ENV["PROJECT_NAME"]);
        /*      
        $avaliativo = User::select('id')->where('id', '>', 0)->get();


         return $response->write(JWT::Generate(['a'=>'b'])); */
    }
}
