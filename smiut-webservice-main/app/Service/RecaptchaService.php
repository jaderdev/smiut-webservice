<?php

namespace App\Service;

interface RecaptchaService
{
    /**
     * @return bool
     */
    public function validate();
}