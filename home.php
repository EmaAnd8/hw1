<?php

    require 'autenticazione.php';

    if (!$userid = checkAuth()) {
    header("Location: home_login.php");
    exit;
    }

?>



        <!doctype html>
        <html>

            <?php

                    //carico le informazioni dell'tente loggato
                    $conn=mysqli_connect($db_conf['host'],$db_conf['user'],$db_conf['password'],$db_conf['name']) or die(mysqli_error($conn));
                    //ottengo le informazioni sull'utente
                    $userid=mysqli_real_escape_string($conn,$userid);
                    //eseguo la query per ottenere le info
                    $query="SELECT username,nome,cognome FROM utenti WHERE id_user= '$userid'";
                    $info=mysqli_query($conn,$query);

                             if(mysqli_num_rows($info)===1) {
                                 $ans=mysqli_fetch_assoc($info);
                             }else
                             {
                                 $error="non abbiamo lo user con quell'id";
                             }
            ?>
            <head>
                     <meta charset="utf-8">
                     <meta name="viewport" content="width=device-width, initial-scale=1">
                     <link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
                     <link rel="stylesheet"  href="home.css">
                     <script src="home_inter.js" defer></script>
                     <title>home</title>
                     </head>

            <body>
                <div class="style">

                     <header>

                         <nav>
                                <img src="Logo.png" id="XL">
                                <div id="search">
                                 <img src="Ricerca.png" >
                                 <input type="text" id="X12">
                                 </div>

                                 <a href="home.php">home</a>
                                 <a  href="artisti.php">artisti</a>
                                 <a href="album.php">album</a>
                                 <a href="autori.php">autori</a>
                                 <a href="logout.php">Logout</a>


                         </nav>

                     </header>


            </div>

                    <section id="profile">
                        <div>
                            <img src="contattaci.png">
                            <h1>Benvenuto <?php echo $ans['username'] ?></h1>
                            <p>
                                La tua home page personalizzata ti offre tutta la musica che ami in un unico posto.
                                Dai un'occhiata ai tuoi consigli e inizia ad ascoltare: più musica ascolti, migliori saranno i consigli che otterrai!
                            </p>
                        </div>
                    </section>


                <main id="main-container">
                <section id="contents">

                    <div id="container1" >
                    <h1>Album</h1>
                    <div class="X1234">
                    </div>
                    </div>
                    <div id="container2" >
                        <h1>Tracks</h1>
                        <div class="X1234">
                        </div>
                    </div>
                    <div id="container3">
                        <h1>Artists</h1>
                        <div class="X1234">
                        </div>
                    </div>

                </section>
                <section id="contents_hidden">


                    <div id="cont-container1" class="hidden">
                    <h1>Album</h1>
                        <div class="X1234">
                        </div>
                        </div>
                        <div id="cont-container2" class="hidden">
                            <h1>Tracks</h1>
                            <div class="X1234">
                            </div>
                            </div>
                            <div id="cont-container3" class="hidden">
                                <h1>Artists</h1>
                                <div class="X1234">
                                </div>
                                </div>

                </section>
                </main>

                <main  id="lyrics">

                        <section>
                            <h1>Cerca la canzone che ti piace!</h1>

                            <form>
                        <div>
                            <label>

                                <input type="text" name="artista"  id="artist" placeholder="Artista" >
                            </label>
                        </div>

                        <div>
                            <label>

                                <input type="text" name="titolo"  id="song" placeholder="titolo canzone">
                            </label>
                        </div>

                                <div>

                                    <label> &nbsp <input type="button" id="invio" value="cerca"></label>
                                </div>

                            </form>
                            <iframe class="hidden" src="" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>


                        </section>


                        <section>
                            <div id="testo">

                            </div>
                        </section>

                </main>
                <footer class="style">
                    <em>&copy; DBrecords srl</em>
                    <address>Via Nazionale (RM)</address>
                    <p>nome:Emanuele Andaloro Matricola:O46002006</p>
                    <br>
                    <a class="button1" href="https://it-it.facebook.com"></a>
                    <a class="button2" href="https://twitter.com/?lang=it"></a>
                    <a class="button3"  href="https://www.instagram.com"></a>
                </footer>

            </body>
        </html>


<?php mysqli_close($conn); ?>


