const quizDB = [
    {
        question: "What language is used to write Node.js applications?",
        options: ["Java", "C++", "python", "Javascript"], 
        answer: "d",
    }, 
    {
        question: "What language is used to write graphics applications?",
        options: ["Java", "C++", "python", "Javascript"], 
        answer: "b",
    }, 
    {
        question: "What language is used to write Jason's applications?",
        options: ["Java", "C++", "python", "Javascript"], 
        answer: "a",
    }, 
    {
        question: "What language is used to write info retrieval applications?",
        options: ["Java", "C++", "python", "Javascript"], 
        answer: "c",
    }
]

let currentQuestion = 0;
let score = 0;
window.addEventListener("load", displayQuestion);
function displayQuestion(){
    var q = quizDB[currentQuestion];
    document.getElementById("question").innerHTML = q.question;
    document.getElementById("choice1Label").innerHTML = q.options[0];
    document.getElementById("choice2Label").innerHTML = q.options[1];
    document.getElementById("choice3Label").innerHTML = q.options[2];
    document.getElementById("choice4Label").innerHTML = q.options[3];
}

const submitButton = document.querySelector("button");
submitButton.addEventListener("click", checkAnswer);
function checkAnswer(){
    //document.body.style = "color:red";
    let userAnswer;
    var choices = document.getElementsByName("answer");
    for (i=0; i<choices.length;i++){
        if (choices[i].checked){
            userAnswer = choices[i].id;
            break;
        }
    }
    if(userAnswer){
        console.log("moving to next question");
        if(userAnswer == quizDB[currentQuestion].answer){
            score++;
            document.getElementById("resultP").innerHTML = "Your current score is " + score;

        }
        currentQuestion++;
        if (currentQuestion <quizDB.length){
            displayQuestion();
        }else{
            document.getElementById("quizPage").innerHTML="";
            document.getElementById("resultP").innerHTML="You answered "+score+" out of "+quizDB.length+" questions correctly";
        }
        }
    
}

