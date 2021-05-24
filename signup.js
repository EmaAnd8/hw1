
const divMain = document.querySelector("#checker");

const usernameCheck = document.querySelector("#user");
const form_reg=document.querySelector("form")
const passwordCheck = document.querySelector("#pwd");
const mailField = document.querySelector("#e-mail");
const checkRules = document.querySelector("#accettazione");
const verifyMail = document.querySelector("#conferma_mail");
const verifyPassword = document.querySelector("#conferma_pwd");
verifyMail.addEventListener('keyup', checkConfirmEmail);
verifyPassword.addEventListener('keyup', checkConfirmPassword);
usernameCheck.addEventListener('keyup', checkUsername);
passwordCheck.addEventListener('keyup', checkPassword);
mailField.addEventListener('keyup', checkMail);
form_reg.addEventListener('submit', checkAgreement);


function onResponse(response) {
    if (!response.ok) return null;
    return response.json();
}

function isEmpty(Field){

    return !/^[a-zA-Z0-9_]{1,15}$/.test(Field.value);
}



function checkUsername(event){

    const padre =event.currentTarget.parentNode.parentNode;
    if(isEmpty(usernameCheck)){

        const successMessage = document.querySelector("#SuccessUsername");
        if(successMessage !== null){
            successMessage.remove();
        }

        const errorMessage = document.querySelector("#EmptyUser");
        if(errorMessage !== null){
            errorMessage.remove();
        }
        const error = document.createElement("span");
        error.textContent ="Il campo username non può essere vuoto!";
        error.id ="EmptyUser"
        error.classList.add("error");
        padre.appendChild(error);

    }else{
        const errorMessage = document.querySelector("#EmptyUser");
        if(errorMessage !== null){
            errorMessage.remove();

        }
        fetch("check_user.php?q="+encodeURIComponent(usernameCheck.value)).then(onResponse).then(jsonCheckUsername);

    }

}

function jsonCheckUsername(json){
     const figlio =document.querySelector("#user");

    const padre=figlio.parentNode.parentNode;

    if(json.exists === true && !isEmpty(usernameCheck)){

        const successMessage = document.querySelector("#SuccessUsername");
        if(successMessage !== null){
            successMessage.remove();
        }
        const errorMessage = document.querySelector("#ExistingUser");
        if(errorMessage === null){
            const error = document.createElement("span")
            error.textContent ="Username già esistente";
            error.id ="ExistingUser";
            error.classList.add("error");
            padre.appendChild(error);
        }


    }else{
        const errorMessage = document.querySelector("#ExistingUser");
        if(errorMessage !== null){
            errorMessage.remove();
        }
        const successMessage = document.querySelector("#SuccessUsername");
        if(successMessage === null){
            const success = document.createElement("span");

            success.classList.add("ok");
            success.id = "SuccessUsername";
            success.textContent ="Username disponibile!";
            padre.appendChild(success);
        }

    }
}




function checkPassword(event){

    const padre= event.currentTarget.parentNode.parentNode;
    const regExp = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,15})");

    if(!regExp.test(passwordCheck.value)){

        const errorMessage = document.querySelector("#NotValidPassword");
        if(errorMessage === null){
            const error = document.createElement("span");
            error.classList.add("error");
            error.id = "NotValidPassword";
            error.textContent = "La password non rispetta i criteri. ";

            padre.appendChild(error);

        }
        const successMessage = document.querySelector("#SuccessPassword");
        if(successMessage !== null){
            successMessage.remove();
        }

    }else{

        const errorMessage = document.querySelector("#NotValidPassword");
        if(errorMessage !== null){
            errorMessage.remove();
        }
        const successMessage = document.querySelector("#SuccessPassword");
        if(successMessage === null){

            const success = document.createElement("span");
            success.classList.add("ok");
            success.id ="SuccessPassword";
            success.textContent ="Password buona! ";
            padre.appendChild(success);

        }
    }

}



function checkMail(event){

    if  (!/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(String(mailField.value).toLowerCase())){
         const padre =event.currentTarget.parentNode.parentNode;
        const errorMessage2 = document.querySelector("#NotValidEmail");

        if (errorMessage2 === null) {

            const error = document.createElement("span");
            error.classList.add("error");

            error.id = "NotValidEmail";
            error.textContent = "Formato non valido";
            padre.appendChild(error);

        }

        const successMessage = document.querySelector("#SuccessEmail");
        if(successMessage !== null){
            successMessage.remove();
        }

    }else{

        const errorMessage2 = document.querySelector("#NotValidEmail");
        if(errorMessage2 !== null){

            errorMessage2.remove();

        }

        const success = document.querySelector("#SuccessEmail");
        if(success === null){

            const successMessage = document.createElement("span");
            successMessage.textContent ="Formato email corretto";
            successMessage.classList.add("ok");
            successMessage.id = "SuccessEmail";
            padre.appendChild(successMessage);
        }

    }

}

function checkAgreement(event){

    const checkbox = document.getElementById('accettazione');
    const div =checkbox.parentNode.parentNode;
    if(checkbox.checked === false){

        event.preventDefault();
        const error = document.createElement("span");
        error.classList.add("error");
        error.textContent="accetta l'utilizzo dei dati personali";
        div.appendChild(error);

    }
}

function checkConfirmEmail(event){

   const padre=event.currentTarget.parentNode.parentNode;

    if(mailField.value === verifyMail.value){


        if(document.querySelector("#EmailsEqual") === null){
            const success = document.createElement("span");
            success.classList.add("ok");
            success.textContent ="Le email coincidono";
            success.id = "EmailsEqual";
            padre.appendChild(success);
        }

        const error = document.querySelector("#EmailsNotEqual");
        if(error !== null){
            error.remove();
        }

    }else{

        const success = document.querySelector("#EmailsEqual");
        if(success !== null){
            success.remove();
        }

        if(document.querySelector("#EmailsNotEqual") === null){
            const error = document.createElement("span");
            error.classList.add("error");

            error.textContent ="Le email non coincidono";
            error.id = "EmailsNotEqual";
            padre.appendChild(error);
        }

    }

}

function checkConfirmPassword(event){

   const  padre= event.currentTarget.parentNode.parentNode;

    if(passwordCheck.value === verifyPassword.value) {

        if (document.querySelector("#PasswordEqual") === null) {
            const success = document.createElement("span");
            success.classList.add('ok');
            success.textContent = "Le password coincidono";
            success.id = "PasswordEqual";
            padre.appendChild(success);
        }

        const error = document.querySelector("#PasswordNotEqual");
        if (error !== null) {

            error.remove();
        }


    }else{

        const success = document.querySelector("#PasswordEqual")

        if(success !== null){

            success.remove();

        }

        if(document.querySelector("#PasswordNotEqual") === null){

            const error = document.createElement("span");
            error.classList.add("error");
            error.textContent ="Le password non coincidono";
            error.id = "PasswordNotEqual";
            padre.appendChild(error);

        }

    }

}
