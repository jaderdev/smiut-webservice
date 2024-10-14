<?php

namespace App\Service;

use App\Exception\BadRequestException;
use App\Exception\RuntimeException;
use App\Factory\MailerFactory;
use  App\Service\MailContentService as MailContentService;

class MailService
{
    private $mailTo;
    private $acceptTerms = true;
    private $acceptNewsletter = true;
    /**
     * @var RecaptchaService
     */
    private $recaptcha = null;
    private $template = 'Templates/mail/default.php';

    public function __construct($mailTo)
    {
        $this->mailTo = $mailTo;
    }

    /**
     * @param mixed $acceptTerms
     */
    public function setAcceptTerms($acceptTerms)
    {
        $this->acceptTerms = $acceptTerms;
    }

    /**
     * @param mixed $acceptNewsletter
     */
    public function setAcceptNewsletter($acceptNewsletter)
    {
        $this->acceptNewsletter = $acceptNewsletter;
    }

    /**
     * @param RecaptchaService $recaptcha
     */
    public function setRecaptcha($recaptcha)
    {
        $this->recaptcha = $recaptcha;
    }

    /**
     * @param string $template
     */
    public function setTemplate(string $template): void
    {
        $this->template = $template;
    }

    /**
     * @throws BadRequestException
     */
    private function validate()
    {
        if(!$this->acceptTerms)
        {
            throw new BadRequestException("Accept terms to continue.");
        }
        if(!$this->acceptNewsletter)
        {
            throw new BadRequestException("Accept newsletter to continue.");
        }
        if(!is_null($this->recaptcha) && $this->recaptcha instanceof RecaptchaService)
        {
            $this->recaptcha->validate();
        }
    }

    /**
     * @param $subject
     * @param $content
     * @param bool $useTemplate
     * @throws RuntimeException
     * @throws BadRequestException
     */
    public function send($subject, $content, $useTemplate = true)
    {
        $this->validate();
        if($content instanceof MailContentService)
        {
            $content = $content->render();
        }

        if($useTemplate)
        {
            $body = require APP_ROOT.'/app/Templates/mail/default.php';
            $mailService = new MailContentService;
            $body = $mailService->format($body,$subject);
        }
        else
        {
            $body = $content;
        }

        try
        {
            $mailerFactory = new MailerFactory();
            $mailer = $mailerFactory->createMailer();
            if(is_array($this->mailTo))
            {
                foreach($this->mailTo as $value)
                {
                    $mailer->addAddress($value);
                }
            }
            else
            {
                $mailer->addAddress($this->mailTo);
            }
            $mailer->Subject = $subject;
            $mailer->Body = $body;
            $mailer->isHTML(true);
            $mailer->send();
            return [
                'body' => $body,
                'message' => 'Email successfully sent'
            ];
        }
        catch(\Exception $e)
        {
//            throw new RuntimeException('Fail to send mail.');
            throw new RuntimeException($e);
        }
    }
}