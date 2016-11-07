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
      markup: marked(fs.readFileSync('public/data/about.md', 'utf8'))
    },
    projects: JSON.parse(fs.readFileSync('public/data/projects.json', 'utf8')),
    posts: []
  };

  const postdates = JSON.parse(fs.readFileSync('public/data/posts.json', 'utf8'));
  for(var counter = 0; counter < postdates.length; counter++){
    const postdate = postdates[counter];
    var path = 'public/data/posts/' + postdate + '.md';
    content.posts.push({
      date: postdate,
      markup: marked(fs.readFileSync(path, 'utf8'))
    });
  }

  res.render('index', {content});
});

app.get('/planet-clock', (req, res) => {
  res.render('clock');
});

app.listen(process.env.PORT || 5000);
