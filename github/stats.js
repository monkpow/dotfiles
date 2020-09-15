debugger

const fs = require('fs')
const https = require('https')
const url = require('url')

const homedir = require('os').homedir();
const AUTHORIZATION_TOKEN = fs.readFileSync(homedir + '/.github_authtoken').toString().replace(/\n/,'')

//curl -H "Authorization: token "  https://api.github.com/repos/blue-lava/BlueLavaPortal/pulls/1000/reviews

const endpoints = {
  root: "https://api.github.com/",
  owner: "https://api.github.com/repos/blue-lava/",
  pulls: "https://api.github.com/repos/blue-lava/BlueLavaPortal/pulls"
}


function requestK(uri) {
  let parts = url.parse(uri)

  debugger
  return new Promise(function(resolve, reject) {
    var options = {
      headers: {
        Authorization: "#{AUTHORIZATION_TOKEN}",
        "User-Agent": "Awesome-Octocat-App"
      }
    };

    https.get(uri, options, (resp) => {
      debugger
      let data = '';

      // A chunk of data has been received.
      resp.on('data', (chunk) => {
        debugger
        data += chunk;
      });

      // The whole response has been received. Print out the result.
      resp.on('end', () => {
        debugger
        resolve(data)
      });

    }).on("error", (err) => {
      debugger
      reject(resp)
      console.log("Error: " + err.message);
    });
  })
}


requestK(endpoints.owner).then(function(x) {
  console.log(x)
  debugger;
})
debugger


return
let results = {}


for (var i=1; i<=1000; i++) {
  filename= "reviews_pr_" + i + ".json"
  xx = fs.readFileSync(filename)
  hell_yeah = JSON.parse(xx.toString())
  hell_yeah.forEach(x => {
    results[x.user.login] = results[x.user.login] || {}
    results[x.user.login][x.state] = results[x.user.login][x.state] || 0
    results[x.user.login][x.state] += 1
  })

}


console.log(results)
