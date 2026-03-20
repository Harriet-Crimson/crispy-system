/*
 Created on: 17/03/2026
 version: 1.0.0
 description: JavaScript for the backend of the login page -- sign in function.
 author(s): Keelan
 date: 17/03/2026
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



//from sign in page click sign up button, takes to sign up page.
let signUpButton = document.getElementById("signUpButton");//ID subject to change
signUpButton.addEventListener("submit", displaySignUp);
function displaySignUp(){
    //changes sign up variable
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

//Enter email, first name, last name and password 
let emailInput = document.getElementById("email");
let firstNameInput = document.getElementById("firstName");
let lastNameInput = document.getElementById("lastName");
let passwordInput = document.getElementById("password");

let email = emailInput.value;
let firstName = firstNameInput.value;
let lastName = lastNameInput.value;
let password = passwordInput.value; //should hash at some point

let validCredentials = false;

//validate credentials
// if (valid){validCredentials= true;}

          
//if correct credentials
//display user page

//if invalid credentials
// display error message
if (!validCredentials){
    alert("Invalid credentials. Please enter correct username and password");
}
