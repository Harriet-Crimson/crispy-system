//assumes corresponding html uses <input type = "file" id="uploadFile"> 
let uploadFile = document.getElementById("uploadFile");
uploadFile.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const formData = new FormData();
        formData.append("file", file);
        fetch("/semesterFileUploaded", {
            method: "POST",
            body: formData, 
        })
    }
})
