const https = require("https"),
  fs = require("fs");

const options = {
  key: fs.readFileSync("/run/secrets/tls/tls.key"),
  cert: fs.readFileSync("/run/secrets/tls/tls.crt")
};

const express = require('express')

const app = express();

// parse application/json
var bodyParser = require('body-parser')
app.use(bodyParser.json())

app.post('/mutate', (req,res) => {
    console.log(JSON.stringify(req.body, null, '\t'));
    res.json({ uid: req.body.request.uid, allowed: true });
});

// app.use((req, res) => {
//   res.writeHead(200);
//   res.end("hello world\n");
// });

app.listen(8000);

https.createServer(options, app).listen(8443, () => {
  console.log("Admission controller ready");
});
