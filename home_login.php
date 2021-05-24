<pre>
<?php

session_start();
session_destroy();
include 'autenticazione.php';


if (checkAuth()) {
    header('Location: home.php');
    exit;
}

if (!empty($_POST["username"]) && !empty($_POST["password"])) {

    $conn = mysqli_connect($db_conf['host'], $db_conf['user'], $db_conf['password'], $db_conf['name']) or die(mysqli_error($conn));

    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $query = "SELECT id_user, username, password FROM utenti WHERE username='$username'";
    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));

    if(mysqli_num_rows($res)>0){
        $row =mysqli_fetch_assoc($res);


        if(password_verify($password, $row['password'])){

            $_SESSION['username'] = $row['username'];
            $_SESSION['id_user'] = $row['id_user'];
            header("Location: home.php");
            mysqli_free_result($res);
            mysqli_close($conn);
            exit;

        }else{
            $error = "Password errata";

        }

    }else{
        $error ="Credenziali non valide. \n";
    }
}else{
     $error='nessun campo può essere vuoto';
}


?>
</pre>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="login.css">
</head>

<body>

<section>



    <div id="main-div">

        <form name="login"  method="post">
            <img src="Logo.png">
            <h1>Accedi</h1>
            <div>
                <label>

                    <input type="text" name="username"  id="user" placeholder="Username"  maxlength="15" <?php if(isset($_POST["username"])){echo "value=".$_POST["username"];} ?>>
                </label>
            </div>

            <div id="pwd-div">
                <label>

                    <input type="password" name="password"  id="pwd" placeholder="Password" maxlength="15">
                </label>
            </div>


            <div>

                <label> &nbsp <input type="submit" id="invio" value="Login"></label>
            </div>


            <label><span>Non hai un account?<span></span> <a href="registrazione.php">Registrati</a></label>
            <span class="error"> <?php if(isset($error)){echo $error;}?></span>
        </form>

    </div>
</section>


</body>
</html>

					
