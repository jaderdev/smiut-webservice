<?php namespace App\Middleware;

use App\Exception\BaseException;
use App\Exception\MaintenanceException;
use App\Exception\NotFoundException;
use App\Exception\RuntimeException;
use DI\Container;
use Dtkahl\SimpleConfig\Config;
use Monolog\Logger;
use Slim\Handlers\Error;
use Slim\Handlers\PhpError;
use Slim\Http\Request;
use Slim\Http\Response;

class ExceptionHandlingMiddleware
{

    private $config;
    private $logger;
    private $container;

    public function __construct(Container $container, Config $config, Logger $logger)
    {
        $this->container = $container;
        $this->config = $config;
    }

    public function __invoke(Request $request, Response $response, callable $next)
    {
        try {
            if ($this->isMaintenance()) {
                throw new MaintenanceException;
            }
            if (is_null($request->getAttribute("route"))) {
                throw new NotFoundException;
            }
            $response = $next($request, $response);
        } catch (\Exception $e) {
            $response = $this->handleException($request, $response, $e);
        } catch (\Throwable $e) {
            $response = $this->handleException($request, $response, $e);
        }
        return $response;
    }

    /**
     * @param Request $request
     * @param Response $response
     * @param \Exception|\Throwable $exception
     * @return Response
     */
    public function handleException(Request $request, Response $response, $exception) {
        // print_r($exception);
        return    $response->withStatus(500)
        ->withHeader('Content-Type', 'application/json')
        ->withJson(['message' => 'Error to process request', 'data' => $exception->getMessage() ]);
  
    }

    public function isMaintenance()
    {
       
    }

 

}
