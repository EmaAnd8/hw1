<?php
    
    require_once 'dbconfig.php';
    session_start();

    function checkAuth() {
        // Se esiste già una sessione, la ritorno, altrimenti ritorno 0
        if(isset($_SESSION['id_user'])) {
            return $_SESSION['id_user'];
        } else 
            return 0;
    }
?>