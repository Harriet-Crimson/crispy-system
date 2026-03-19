document.addEventListener("DOMContentLoaded", () => {
  let thing = document.getElementById("Test");

  let uploadFile = document.getElementById("uploadFile");
  uploadFile.addEventListener("change", async function(file) {
        const Upload = file.target.files[0];
        
        const formData = new FormData();
        formData.append("file", Upload);
    // Choose the appropriate method:
        //reader.readAsText(Upload); 
        
            try {    
            const response = await fetch("/semesterFileUploaded", {
            method: "POST",
            body: formData
        });

        // const result = await response.text();
        // console.log("Server response:", result);
    } catch (err) {
        console.error("Upload failed:", err);
    }
    })
});
