<?php namespace App\Exception;

class BadRequestException extends BaseException
{
    protected $status_code = 400;
    protected $default_message = "Bad Request";
}
