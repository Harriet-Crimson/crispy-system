app.post("/semesterFileUploaded",(req, res)=>{
    //res.json({message: "success"});
    console.log("Some");
    let file = req.Upload;
    let semesterFile = [];
    
    

    fs.createReadStream(file)
    .pipe(csv())
    .on('data', (data) => {
        semesterFile.push(data)
        console.log(data.moduleCode, data.assignmentName, data.assignmentNumber, data.assignmentWeight, data.assignmentDeadline);
        //adds to database?
    });
    
 });


 