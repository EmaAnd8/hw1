<?php

    require 'autenticazione.php';
    require 'dbconfig.php';

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
        $query="SELECT username FROM utenti WHERE id_user= '$userid'";
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
        <link href="authors.css" rel="stylesheet" type="text/css">
        <script src="autori.js" defer></script>
        <title>Autori</title>
    </head>

    <body>
    <div class="style">

        <header>

            <nav>

                 <img id="XL" src="Logo.png">
                    <a href="home.php">home</a>
                    <a  href="artisti.php">artisti</a>
                    <a href="album.php">album</a>
                    <a href="autori.php">autori</a>
                    <a href="logout.php">Logout</a>


            </nav>

        </header>


    </div>
    <main>
     <div id="template">
    <section id="profile">
        <div>
            <img src="contattaci.png">
        <h1> Eccoti <?php echo $ans['username'] ?></h1>
        <p>
            In questa sezione puoi  vedere gli autori da noi  selezionati  da noi per scrivere i migliori brani e le informazioni ad essi inerenti e molto altro ancora.
        </p>
        </div>
    </section>

    <section id="contents">


        <div>
            <br>
            <h1>Autori</h1>
            <div class="X1234">

            </div>

    </section>

    <section class="hidden" id="modal-view">

    </section>
     </div>
        <section id='top_autori'>
            <h1>top autori</h1>
            <div>
                <iframe src="https://open.spotify.com/embed/playlist/37i9dQZF1DX3EvTrESVmN6" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
                <iframe src="https://open.spotify.com/embed/show/6qS10tDyNNlkgugnS1xfMc" width="100%" height="232" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
                <iframe src="https://open.spotify.com/embed/playlist/37i9dQZF1EFDY6AC2Mq9pO" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
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
