<?php


        require 'autenticazione.php';
        require 'dbconfig.php';

        //verifico l'autenticazione
        if(!$userid=checkAuth())
        {
            exit;
        }


        //instauro una connessione al db
        $conn=mysqli_connect($db_conf['host'],$db_conf['user'],$db_conf['password'],$db_conf['name']) or die(mysqli_error($conn));


        //ottengo l'id dell' utente e del preferito
        $userid=mysqli_real_escape_string($conn,$userid);
        $title=mysqli_real_escape_string($conn,$_GET['title']);


        //eseguo la query per rimuovere
        $query="DELETE  FROM preferiti where id='$userid' AND titolo='$title'";

        $res=mysqli_query($conn,$query) or die (mysqli_error($conn));


        // delete ritorna il numero di righe cancellate
        if($res>0)
        {
            //tutto ok
            echo json_encode(array('ok' => true));
        }






        //chiudo la connessione
        mysqli_close($conn);







