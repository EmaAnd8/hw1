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
    $query="SELECT * FROM album ";

    $res=mysqli_query($conn,$query) or die(mysqli_error($conn));

    // verifico se sono presenti preferiti associati a quell'id
    $album=array();
    if(mysqli_num_rows($res)>0)
    {
        while($entry=mysqli_fetch_assoc($res))
        {


            $album[]=array('codice'=>$entry['codice'],'nome'=>$entry['nome'],'genere'=>$entry['genere'],'copertina'=>$entry['copertina'],'numero_brani'=>$entry['numero_brani']);
        }

        //torno un JSON che poi mi servirà nella fetch
        echo json_encode($album);
        mysqli_close($conn);
        exit;
    }

?>



