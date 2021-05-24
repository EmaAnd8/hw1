<?php



//verifico che lo username sia l'unico nel db
include('dbconfig.php');


header('Content-Type:application/json');

$conn=mysqli_connect($db_conf['host'],$db_conf['user'],$db_conf['password'],$db_conf['name']) or die(mysqli_error($conn));

$pwd=mysqli_real_escape_string($conn,$_GET['q']);

$pwd_h=password_hash($pwd,PASSWORD_DEFAULT);
$query="SELECT password 
            FROM utenti
            WHERE password='$pwd_h'";



$result=mysqli_query($conn,$query) or die(mysqli_error($conn));


$json=json_encode(array('exists' => mysqli_num_rows($result)>0 ? true : false));

//ritorno il json
echo $json;

//libero le risorse
mysqli_close($conn);






?>