<?php

namespace App\Factory;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

final class MailerFactory
{
    private $settings;

    public function __construct()
    {
        $this->settings = [
            'debug' => $_ENV["DEBUG"],
            'host' => $_ENV["EMAIL_HOST"],
            'auth' => true,
            'username' => $_ENV["EMAIL_USER"],
            'password' => $_ENV["EMAIL_PASS"],
            'port' => 587,
            'from' => $_ENV["EMAIL_FROM_NAME"],
            'from_email' => $_ENV["EMAIL_FROM_EMAIL"]
        ];
    }

    public function createMailer(): PHPMailer
    {
        require_once("../vendor/phpmailer/phpmailer/src/PHPMailer.php");
        require_once("../vendor/phpmailer/phpmailer/src/Exception.php");
        require_once("../vendor/phpmailer/phpmailer/src/SMTP.php");
        $mail = new PHPMailer(true);

        // Server settings
        $mail->SMTPDebug = $this->settings['debug'];
        $mail->isSMTP();
        $mail->Host = $this->settings['host'];
        $mail->SMTPAuth = (bool)$this->settings['auth'];
        $mail->Username = $this->settings['username'];
        $mail->Password = $this->settings['password'];
        $mail->SMTPSecure = $this->settings['password'];
        $mail->Port = (int)$this->settings['port'];
        $mail->setFrom($this->settings['from_email'],  $this->settings['from']);
        $mail->CharSet = "utf-8";

        return $mail;
    }
}
