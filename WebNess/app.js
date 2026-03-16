const http = require('http');
const fs = require('fs');

const server = http.createServer((request, response)=>{

    if (request.url === '/quiz.js'){
        fs.readFile('quiz.js', function(err, data){
            if (err){
                throw err;
            }
            response.writeHead(200, {'Content-Type': 'text/javascript'});
            response.write(data);
            response.end();
            return;
        });
    }
    else{
        fs.readFile('./quiz.html', function(err, data){
            if (err){
                throw err;
            }
            response.writeHead(200, {'Content-Type': 'text/html'});
            response.write(data);
            response.end();
            return;
        })
    }
});

server.listen(8080);
console.log("node server is running on port 8080")