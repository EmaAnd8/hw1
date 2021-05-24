<?php
                //file obbligatori
                require 'autenticazione.php';
                require 'dbconfig.php';

                        //verifico lo stato dell' autenticazione
                        if(!$userid=checkAuth())
                        {
                            exit;
                        }

                        //specifico il formato restituito
                        header('Type-Content=application/json');


                        //creo una connessione al db
                        $conn=mysqli_connect($db_conf['host'],$db_conf['user'],$db_conf['password'],$db_conf['name']) or die(mysqli_error($conn));


                        //eseguo l'escape
                        $userid=mysqli_real_escape_string($conn,$userid);

                                 $query="select autore.nome,autore.cognome,autore.immagine,autore.descrizione from autore";


                        $res=mysqli_query($conn,$query) or die(mysqli_error($conn));


                        $autori=array();

                        //verifico la presenza di elementi
                        if(mysqli_num_rows($res)>0) {
                            while ($entry = mysqli_fetch_assoc($res)) {

                                $autori[] = array('nome' => $entry['nome'], 'cognome' => $entry['cognome'], 'img' => $entry['immagine'],'descrizione'=> $entry['descrizione']);

                            }
                        }


                        echo json_encode($autori);
                        mysqli_close($conn);
                        exit;


                        ?>
