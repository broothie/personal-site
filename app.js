/* app.js
*/
const express = require('express');
const app = express();
const fs = require('fs');
const marked = require('marked');

app.use(express.static('public'));
app.set('view engine', 'jade');

app.get('/', (req, res) => {
  var content = {
    about: {
      markup: marked(fs.readFileSync('public/res/data/about.md', 'utf8'))
    },
    projects: JSON.parse(fs.readFileSync('public/res/data/projects.json', 'utf8')),
  };

  res.render('index', {content});
});

app.get('/planet-clock', (req, res) => {
  res.render('clock');
});

app.listen(process.env.PORT || 5000);
