var fs = require('fs'),
  path = require('path');

function randomFrom(list) {
  return list[Math.floor(Math.random() * list.length)];
}

function write(err, contents) {
  console.log(contents.toString());
}

function catRandomFile(err, list) {
  fs.readFile(path.join(__dirname, '../ascii', randomFrom(list)), write);
}

fs.readdir(path.join(__dirname, '../ascii'), catRandomFile);
