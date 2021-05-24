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
            $codice=mysqli_real_escape_string($conn,$_GET['codice']);




            //eseguo la query
            $query="SELECT album.codice,brano.Nome FROM album INNER JOIN brano on album.codice=brano.album where album.codice='$codice' ";

            $res=mysqli_query($conn,$query) or die(mysqli_error($conn));

            // verifico se sono presenti preferiti associati a quell'id
            $brani=array();

            if(mysqli_num_rows($res)>0)

            {
                while($entry=mysqli_fetch_assoc($res))
                {


                $brani[]=array('nome'=>$entry['codice'],'brano'=>$entry['Nome']);
                }

                //torno un JSON che poi mi servirà nella fetch
                echo json_encode($brani);
                mysqli_close($conn);
                exit;
            }

?>




