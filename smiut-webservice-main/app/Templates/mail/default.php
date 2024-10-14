<?php
$htmlTemplate = '<html>';
$htmlTemplate .= require(__DIR__ . '/_head.php');
$htmlTemplate .= '<body>';
$htmlTemplate .= '<div 
    style="border-bottom: 1px solid #CCD3D1;
    padding: 50px 0px; font-size: 12px; line-height: 18px; color: #3c3b3b;">';
$htmlTemplate .= $content;
$htmlTemplate .= "</div>";
$htmlTemplate .= '</body>';
$htmlTemplate .= require(__DIR__ . '/_foot.php');
$htmlTemplate .= '</html>';

return $htmlTemplate;
