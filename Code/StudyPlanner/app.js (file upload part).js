
//npm install csv-parse
//npm install multer

const express = require("express");
const multer  = require("multer");
const upload = multer({ storage: multer.memoryStorage() }); 
const app = express();
const path = require("path");

const { parse } = require("csv-parse/sync"); 

app.get("/", (req, res) => {
    res.sendFile((path.join(__dirname,'index.html')), (err)=>{
        if (err);
        console.log(err);
    });
});

app.post("/semesterFileUploaded", upload.single("file"), (req, res) => {
    const fileContent = req.file.buffer.toString("utf-8");
    
    const semesterFile = parse(fileContent, {
        columns: true,   // first row used as headers
        skip_empty_lines: true
    });
    console.log(semesterFile);
    console.log(semesterFile[0].assignmentName);    
    
});

app.listen(3000, () => console.log("Server running on port 3000"));