<?php
require('dbconfig.php');

if(!empty($_POST['username']) && !empty($_POST['nome']) && !empty($_POST['nome']) &&  !empty($_POST['email']) && !empty($_POST['conferma_email']) && !empty($_POST['password']) && !empty($_POST['conferma_password']) &&  isset($_POST['check'])){


    $conn = mysqli_connect($db_conf['host'], $db_conf['user'], $db_conf['password'], $db_conf['name']) or die(mysqli_error($conn));


    $username = mysqli_real_escape_string($conn, $_POST['username']);

    if(!filter_var($_POST['email'],FILTER_VALIDATE_EMAIL))
    {
        $error='email non valida';
        print $error;
    }else{
        $mail = mysqli_real_escape_string($conn, $_POST['email']);
    }

    $mail_confirm = mysqli_real_escape_string($conn, $_POST['conferma_email']);
    $nome=mysqli_real_escape_string($conn,$_POST['nome']);
    $cognome=mysqli_real_escape_string($conn,$_POST['cognome']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $password_confirm = mysqli_real_escape_string($conn, $_POST['conferma_password']);
    $value=password_hash($password,PASSWORD_DEFAULT);
    //Controllo che l'username non sia gia presente

    $query = "SELECT * FROM utenti where username='$username'";

    $res = mysqli_query($conn,$query);

    if(!mysqli_num_rows($res)>0){

        //Controllo anche la mail affinchè non sia presente nel db
        $mail_check = "SELECT email from utenti where email='$mail'";



        $res2 = mysqli_query($conn, $mail_check);
        if(!mysqli_num_rows($res2) > 0){


            //Procedo a verificare che i campi di conferma sono uguali tra loro
            if(strcmp($mail,$mail_confirm)=== 0 && password_verify($password_confirm,$value)){


                $query3="INSERT INTO utenti(password, email,nome,cognome,username) VALUES ('$value','$mail','$nome','$cognome','$username')";

                if (mysqli_query($conn, $query3)) {
                    $_SESSION["user_id"] = $_POST["username"];
                    $_SESSION["user_id"] = mysqli_insert_id($conn);
                    header('Location:home_login.php');
                    mysqli_close($conn);

                    exit;
                } else {
                    $error = "Errore di connessione al Database";
                }


            }else{

                $error = "I dati nei campi di conferma non coincidono.";
                print_r($error);
            }


        }else{
            $error = "Email già presente in DB";
            print_r($error);
        }

    }else{

        $error = "Username già in uso.";
        print_r($error);
    }


}else{

    $error ="Riempi tutti i campi.";

}


?>



<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Sign up</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="signup.js" defer></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="registrazione.css">
</head>

	<body>



    <main>
        <section id="locus">
            <div id="logo" >
                <img src="concert.jpg">
            </div>
        </section>

		<section id="locus-form">





			<div id="main-div">

				<form name="registration"  method="post">
                    <img src="Logo.png">
                    <h1>Registrati</h1>
                    <div>
                        <label>

                            <input type="text" name="username"  id="user" placeholder="Username"  maxlength="15" <?php if(isset($_POST["username"])){echo "value=".$_POST["username"];} ?>>
                        </label>
                    </div>


                    <div >
					<label>

                        <input type="text" name="nome" id="name" placeholder="Nome" <?php if(isset($_POST["nome"])){echo "value=".$_POST["nome"];} ?>>
                    </label>
                        </div>
                    <div >
					<label>

                        <input type="text" name="cognome" id="surname" placeholder="Cognome" <?php if(isset($_POST['cognome'])) {echo "value=".$_POST['cognome'];}?>>
                    </label>
                    </div>
                            <div>
                            <label>

                        <input type="text" name="email"  id="e-mail"  placeholder="Email" <?php if(isset($_POST["email"])){echo "value=".$_POST["email"];} ?>>
                    </label>
                            </div>
                    <div>
                        <label>

                            <input type="text" name="conferma_email"  id="conferma_mail" placeholder="Conferma Email" >
                        </label>
                    </div>
                     <div>
					<label>

                        <input type="password" name="password"  id="pwd" placeholder="Password"  maxlength="15">
                    </label>
                     </div>

                    <div>
                        <label>

                            <input type="password" name="conferma_password"  id="conferma_pwd" placeholder="Conferma Password"  maxlength="15">
                        </label>
                    </div>

                    <div>

                        <label> &nbsp <input type="submit" id="invio" value="Sign up"></label>
                    </div>
                    <div>
                        <label id="checker">
                            <input type="checkbox" name="check[]" value="1"  id="accettazione">
                            <span>Acconsento al trattamento dei miei dati personali</span>
                        </label>

                    </div>

                    <label><span>Hai un account?<a href="home_login.php">Accedi</a> o <a href="Newsletter.php">Newsletter</a></span> </label>
                </form>
				
			</div>
		</section>
    </main>

	</body>
</html>
