<?php
        require 'dbconfig.php';


if(!empty($_POST['email']) && !empty($_POST['descrizione']) && !empty($_POST['checkbox']) ) {
    //instauro una connessione al db
    $conn = mysqli_connect($db_conf['host'], $db_conf['user'], $db_conf['password'], $db_conf['name']) or die(mysqli_error($conn));
    if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
        $error='email non valida';
    }

    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $descrizione = mysqli_real_escape_string($conn, $_POST['descrizione']);
    $bool = mysqli_real_escape_string($conn, $_POST['checkbox']);
    //eseguo una query per verificare se l'indirizzo è presente nella tabella user
    $query = "SELECT * FROM utenti where email='$email'";
    $res = mysqli_query($conn, $query);

    $query1 = "SELECT * FROM newsletter where email='$email'";
    $res_2 = mysqli_query($conn, $query1);


    //verifico se è già presente un utente
    if (mysqli_num_rows($res) > 0) {

        //non hai bisogno di usare la newsletter se sei già un utente
        mysqli_free_result($res);
        mysqli_close($conn);
        header("Location:home_login.php");
        exit;
    } else if (mysqli_num_rows($res_2) > 0) {

                $error='hai già la newsletter premi invia e lascia una descrizione';
                $query_2 = "INSERT INTO newsletter(descrizione,checkbox,email) values ('$descrizione','$bool','$email')";
                mysqli_query($conn, $query_2);

        mysqli_free_result($res_2);
        mysqli_close($conn);

    } else {
        //inserisco l'email nella tabella newsletter insieme ai dati associati a quella richiesta

        $query = "INSERT INTO newsletter(descrizione,checkbox,email) values ('$descrizione','$bool','$email')";
        if(mysqli_query($conn, $query)) {
            $ok = "Bravo, adesso fai parte della nostra newsLetter";
        }
    }
}
else
{
    $error='riempi tutti i campi necessari';
}

?>




<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>NewsLetter</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="newsletter.css">
</head>

	<body>

		<section>



			<div >

				<form name="newsletter"  method="post">
                    <img src="Logo.png">
                    <h1>NewsLetter</h1>
                    <span>
                        Se ci comunichi il tuo indirizzo e-mail,
                        riceverai la newsletter mensile che ti aggiorna in anteprima su notizie, eventi, lanci di nuovi prodotti e molto di più!
                    </span>
                    <br>
                    <br>
                    <div>
					<label>
					<input type="text" name="email" placeholder="E-mail" <?php if(isset($_POST["email"])){echo "value=".$_POST["email"];} ?>>
                    </label>
                    </div>
                    <div>
                    <label>
                    <textarea name="descrizione" rows="4" cols="50" placeholder="Qui puoi farci le tue domande?" <?php if(isset($_POST["descrizione"])){echo "value=".$_POST["descrizione"];} ?>></textarea>
                    </label>
                    </div>
                    <label><input type="submit" id="invio" value="invia"></label>
                    <div>
                        <label id="checker">
                            <input type="checkbox" name="check[]" value="1"  id="accettazione">
                            <span>Acconsento al trattamento dei miei dati personali</span>
                        </label>

                    </div>
                    <label><span>Vuoi saperne di più?<span></span> <a href="registrazione.php">Registrati</a></label>
                    <div>
                        <label>
                        <a class="button1" href="https://it-it.facebook.com"></a>
                        <a class="button2" href="https://twitter.com/?lang=it"></a>
                        <a class="button3"  href="https://www.instagram.com"></a>
                        </label>
                    </div>
                </form>

			</div>
		</section>


	</body>
</html>

