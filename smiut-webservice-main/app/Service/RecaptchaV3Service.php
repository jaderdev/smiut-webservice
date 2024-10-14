<?php

namespace App\Service;

use App\Exception\BadRequestException;

class RecaptchaV3Service implements RecaptchaService
{
    /**
     * @return bool
     * @throws BadRequestException
     */
    public function validate()
    {
        if(false)
        {
            throw new BadRequestException("Invalid recaptcha.");
        }

        return true;
    }
}