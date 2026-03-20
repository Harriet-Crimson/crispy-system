/*
 Created on: 17/03/2026
 version: 1.0.0
 description: JavaScript for the backend of the login page - for the sign up function.
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


//probably needed later
// document.addEventListener("DOMContentLoaded", () => {
//   fetch(jsonFile)
//     .then((response) => response.json())
//     .then((resData) => {



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

//Enter email, first name, last name and password 
let emailInput = document.getElementById("email");
let firstNameInput = document.getElementById("firstName");
let lastNameInput = document.getElementById("lastName");
let passwordInput = document.getElementById("password");

let email = emailInput.value;
let firstName = firstNameInput.value;
let lastName = lastNameInput.value;
let password = passwordInput.value; //should hash at some point

//select staff or student 
let accountTypeInput = document.getElementById("accountTypeField"); //NB: may be repeat of accountTypeDisplay
if (accountTypeInput[0].checked){
    let accountType = "student";//Can be used to dictate which table they are insterted into -AG
}else if(accountTypeInput[1].checked){
    let accountType = "staff";
}else{
    let accountType = "invalid";
}

//input validation
/* TO DO:
Password must be 8 characters
Must use combination of numbers, lower case and upper case characters and special characters.
Ensure SQL commands etc have no impact
*/
// pattern for digits, special characters, lowercase letters amd upper case letters, ensuring at least 8 characters long and ensures at least one of each character type
// ^ is start of pattern, $ is end of pattern
let regex = /^(?=.*\d)(?=.*[!@#$%^&?<>()])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
if (password.value.match(regex) && accountType != "invalid"){
  //add credentials to database
   
else{ //can be more specific later
    alert("Invalid credentials. Please enter valid password ( Password must be 8 characters. Must use combination of numbers, lower case and upper case characters and special characters) and ensure an account type is selected");
}

