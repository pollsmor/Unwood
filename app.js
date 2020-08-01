// Using node.js server to send direct m3u8 URL of a stream
// npm init
// npm install --save express
// npm install --save twitch-get-stream

const express = require("express");
const app = express();
const port = 8081;

const twitch = require("twitch-get-stream");

app.get('/stream', function (req, res) {
  //console.log(req);
  
  let channel = req['query']['channel']
  
  let streams = twitch.get(channel)
    .then(streams => res.send(streams))
    .catch(err => res.send("Error."));
});

app.listen(port, () => console.log("App successfully started."));
