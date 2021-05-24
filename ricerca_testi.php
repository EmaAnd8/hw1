<?php
#richiedo l'autenticazione
require_once 'autenticazione.php';

#se la sessione è scaduta esco
if(!$userid=checkAuth())
{
    exit;
}

#specifico il tipo di file
header('Content-Type: application/json');
set_time_limit(500);

$ch = curl_init();
$artist=urlencode($_GET['artista']);

$title=urlencode($_GET['titolo']);

curl_setopt($ch, CURLOPT_URL, 'https://api.lyrics.ovh/v1/'.$artist.'/'.$title.'?limit=200');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($ch, CURLOPT_HEADER, FALSE);


$response = curl_exec($ch);
curl_close($ch);

echo $response;






?>
