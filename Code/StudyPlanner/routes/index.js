/*
 Created on: 17/03/2026
 version: 1.0.0
 description: generated when initialised
 author(s): the system
 date: 17/03/2026
*/

var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
