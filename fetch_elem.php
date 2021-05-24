<?php

    require 'autenticazione.php';
    require 'dbconfig.php';

    if(!$userid=checkAuth())
    {
        exit;
    }


    //contenuto tipo json
    header('Content-Type=application/json');

    //instauro una connessione php
    $conn=mysqli_connect($db_conf['host'], $db_conf['user'],$db_conf['password'],$db_conf['name']) or die(mysqli_error($conn));

    //ottengo l'id di sessione
    $userid=mysqli_real_escape_string($conn,$userid);




    //eseguo la query
    $query="SELECT artista.profilo,artista.nome,artista.inizio_carriera,descrizione FROM artista";

    $res=mysqli_query($conn,$query) or die(mysqli_error($conn));

    // verifico se sono presenti preferiti associati a quell'id
    $artisti=array();
    if(mysqli_num_rows($res)>0)
    {
        while($entry=mysqli_fetch_assoc($res))
        {


            $artisti[]=array('nome'=>$entry['nome'],'time'=>$entry['inizio_carriera'],'img'=>$entry['profilo'],'descrizione'=>$entry['descrizione']);
        }

        //torno un JSON che poi mi servirà nella fetch
        echo json_encode($artisti);
        mysqli_close($conn);
        exit;
    }

?>



