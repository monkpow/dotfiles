#!/bin/bash

fs.readdir('../ascii', function (err, list) { 
  fs.readFile('../ascii/' + list[Math.floor(Math.random() *list.length)], function (err, contents) { 
    console.log(contents.toString()) 
  }) 
})
