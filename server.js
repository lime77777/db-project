const express = require('express');
const path = require('path');
const app = express();
const PORT = 9501;

const mysql = require('mysql2');

const db = mysql.createPool({
  host: 'classmysql.engr.oregonstate.edu',
  user: 'cs340_stepalex', 
  password: '6588', 
  database: 'cs340_stepalex'
});

console.log("Starting server.js...");

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.render('index');
});

app.get('/users', (req, res) => {
    const query = 'SELECT username, email, createdAt FROM Users';

    db.query(query, (err, results) => {
        if (err) {
          console.error("Failed to fetch users:", err);
          res.status(500).send("Database error");
        } else {
          res.render('users', { users: results });
        }
      });
    });

  app.get('/playlists', (req, res) => {
    const query = 'SELECT playlistID, title, description, userID, createdAt FROM Playlists';

    db.query(query, (err, results) => {
        if (err) {
          console.error("Failed to fetch playlists:", err);
          res.status(500).send("Database error");
        } else {
          res.render('playlists', { playlists: results });
        }
      });
    });

  app.get('/artists', (req, res) => {
    const query = 'SELECT artistID, name, country, debutYear FROM Artists';

    db.query(query, (err, results) => {
        if (err) {
          console.error("Failed to fetch artists:", err);
          res.status(500).send("Database error");
        } else {
          res.render('artists', { artists: results });
        }
      });
    });
  

app.get('/songs', (req, res) => {
    const query = 'SELECT title, duration, releaseDate, genre FROM Songs';
  
    db.query(query, (err, results) => {
      if (err) {
        console.error("Failed to fetch songs:", err);
        res.status(500).send("Database error");
      } else {
        res.render('songs', { songs: results });
      }
    });
  });
  
  

app.listen(PORT, () => {
  console.log(`Server running at http://classwork.engr.oregonstate.edu:${PORT}`);
});
