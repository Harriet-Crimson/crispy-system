/*
 Created on: 17/03/2026
 version: 1.0.0
 description: JavaScript for the backend of the login page -- sign in function.
 author(s): Keelan
 date: 17/03/2026
*/


/*Sign up
from sign in page click sign up button, takes to sign up page.
Enter username and password and select staff or student, submit.
Input validation.
Add credentials to database.
Take to user page
*/
/* Log in
Enter username and password, submit.
Check database.
if in database, take to user page.
if not in databse, show error message.
*/

//probably needed later
// document.addEventListener("DOMContentLoaded", () => {
//   fetch(jsonFile)
//     .then((response) => response.json())
//     .then((resData) => {


//variable for sign in or sign up
let signUp = false;

//Sign in
//from sign in page click sign up button, takes to sign up page.
let signUpButton = document.getElementById("signUpButton");//ID subject to change
signUpButton.addEventListener("submit", displaySignUp);
function displaySignUp(){
    //changes sign up variable
    signUp = true;

// changes "sign in" to "sign up"
    let signInText = document.getElementById("signInText");//ID subjext to change
    signInText.textContent = "Sign up";

//removes sign up link, replaces with staff or student selection

    //Very likely to change
    let signUpLink = document.getElementById("signUpLink");//ID subjext to change
    signUpLink.style.display = "none";
    let accountTypeDisplay = document.getElementById("accountType");//ID subjext to change
    accountTypeDisplay.style.display = "flex";
    //assumes inputs for account type are now displayed
}

//Enter username and password 
let usernameInput = document.getElementById("username");
let passwordInput = document.getElementById("password");

let username = usernameInput.value;
let password = passwordInput.value; //should hash at some point

//select staff or student (if signing up)
if (signUp){
    let accountTypeInput = document.getElementById("accountTypeField"); //NB: may be repeat of accountTypeDisplay
    if (accountTypeInput[0].checked){
        let accountType = "student";
    }else if(accountTypeInput[1].checked){
        let accountType = "staff";
    }else{
        let accountType = "invalid";
    }
}




let validCredentials = false;
if (signUp){
    //input validation
    /* TO DO:
    Password must be 8 characters
    Must use combination of numbers, lower case and upper case characters and special characters.
    Ensure SQL commands etc have no impact
    */
// pattern for digits, special characters, lowercase letters amd upper case letters, ensuring at least 8 characters long and ensures at least one of each character type
// ^ is start of pattern, $ is end of pattern
   let regex = /^(?=.*\d)(?=.*[!@#$%^&?<>()])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
   if (password.value.match(regex)){
       //add credentials
   }


}else{
    //validate credentials
    // if (valid){validCredentials= true;}
}
          
//if correct credentials
//display user page

//if invalid credentials
// display error message
if (!validCredentials){
    alert("Invalid credentials. Please enter correct username and password");
}
