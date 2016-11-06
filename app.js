/* app.js
*/
const express = require('express');
const app = express();
const fs = require('fs');
const marked = require('marked');

app.use(express.static('public'));
app.set('view engine', 'jade');

app.get('/', (req, res) => {
  let content = {
    about: {
      markup: marked(fs.readFileSync('public/data/about.md', 'utf8'))
    },
    projects: [
      {
        name: 'Scrumtious',
        link: 'https://scrumtio.us',
      }
    ]
  };
  res.render('index', {content});
});

app.listen(process.env.PORT || 5000);
