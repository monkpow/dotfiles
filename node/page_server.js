var sys = require("sys"),
http = require("http"),
url = require("url"),
path = require("path"),
fs = require("fs");

http.createServer(function(request, response) {
  var uri = url.parse(request.url).pathname;
  console.log(uri);
  var filename = path.join(process.cwd(), uri);
  console.log(filename);
  path.exists(filename, function(exists) {
    if (!exists) {
      response.writeHead(404, {"Content-Type": "text/plain"});
      response.write("404 Not Found\n");
      response.end();
      return;
    }

    fs.readFile(filename, "binary", function(err, file) {
      if (err) {
        response.writeHead(500, {'Content-Type': 'text/plain'});
        response.write(err + "\n");
        response.end();
        return;
      }

        response.writeHead(200, {'Content-Type': 'text/html'});
        response.write(file);
        response.end();
    });
  });
}).listen(8124);

console.log("Server running at http://localhost:8124/");
