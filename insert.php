<?php

            require 'autenticazione.php';
            require 'dbconfig.php';

            if(!$userid=checkAuth())
            {
                exit;
            }


            //instauro una connessione al db
            $conn=mysqli_connect($db_conf['host'],$db_conf['user'],$db_conf['password'],$db_conf['name']) or die($conn);

            //faccio l'escape prima dela query
            $userid=mysqli_real_escape_string($conn,$userid);
            $json_title=mysqli_real_escape_string($conn,$_GET['title']);
            $json_img=mysqli_real_escape_string($conn,$_GET['immagine']);
            $json_type=mysqli_real_escape_string($conn,$_GET['type']);



//eseguo la query per inserire i valori nel db
            $query="INSERT INTO  preferiti(id,titolo,immagine,tipo) values('$userid','$json_title','$json_img','$json_type')";
            mysqli_query($conn,$query);


            //una volta inserito il contenuto chiudo la connessione al  db

            mysqli_close($conn);


?>