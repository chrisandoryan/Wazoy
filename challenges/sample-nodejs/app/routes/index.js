var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/', function(req, res, next) {
  const requestBody = JSON.stringify(req.body);
  console.log(requestBody);
  const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress || 'unknown';
  req.logger.log(requestBody, ip);

  res.status(200).send('Log received');
});


module.exports = router;
