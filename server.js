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
app.use(express.urlencoded({ extended: true }));

// Home route
app.get('/', (req, res) => {
  res.render('index');
});

// USERS ROUTES
app.get('/users', (req, res) => {
  db.query('SELECT * FROM Users', (err, results) => {
    if (err) return res.status(500).send("Database error");
    res.render('users', { users: results });
  });
});

app.post('/users/add', (req, res) => {
  const { username, email } = req.body;
  db.query('INSERT INTO Users (username, email) VALUES (?, ?)', [username, email], (err) => {
    if (err) return res.status(500).send("Insert failed");
    res.redirect('/users');
  });
});

app.post('/users/delete', (req, res) => {
  const userId = req.body.userId;
  db.query('DELETE FROM Users WHERE userID = ?', [userId], (err) => {
    if (err) return res.status(500).send("Delete failed");
    res.redirect('/users');
  });
});

// ARTISTS ROUTES
app.get('/artists', (req, res) => {
  db.query('SELECT * FROM Artists', (err, results) => {
    if (err) return res.status(500).send("Database error");
    res.render('artists', { artists: results });
  });
});

app.post('/artists/add', (req, res) => {
  const { name, genre } = req.body;
  db.query('INSERT INTO Artists (name, genre) VALUES (?, ?)', [name, genre], (err) => {
    if (err) return res.status(500).send("Insert failed");
    res.redirect('/artists');
  });
});

app.post('/artists/delete', (req, res) => {
  const artistId = req.body.artistId;
  db.query('DELETE FROM Artists WHERE artistID = ?', [artistId], (err) => {
    if (err) return res.status(500).send("Delete failed");
    res.redirect('/artists');
  });
});

// SONGS ROUTES
app.get('/songs', (req, res) => {
  db.query('SELECT * FROM Songs', (err, results) => {
    if (err) return res.status(500).send("Database error");
    res.render('songs', { songs: results });
  });
});

app.post('/songs/add', (req, res) => {
  const { title, releaseDate, genre } = req.body;
  db.query('INSERT INTO Songs (title, releaseDate, genre) VALUES (?, ?, ?)', [title, releaseDate, genre], (err) => {
    if (err) return res.status(500).send("Insert failed");
    res.redirect('/songs');
  });
});

app.post('/songs/delete', (req, res) => {
  const songId = req.body.songId;
  db.query('DELETE FROM Songs WHERE songID = ?', [songId], (err) => {
    if (err) return res.status(500).send("Delete failed");
    res.redirect('/songs');
  });
});

// PLAYLISTS ROUTES
app.get('/playlists', (req, res) => {
  db.query('SELECT * FROM Playlists', (err, results) => {
    if (err) return res.status(500).send("Database error");
    res.render('playlists', { playlists: results });
  });
});

app.post('/playlists/add', (req, res) => {
  const { title, description, userID } = req.body;
  db.query('INSERT INTO Playlists (title, description, userID) VALUES (?, ?, ?)', [title, description, userID], (err) => {
    if (err) return res.status(500).send("Insert failed");
    res.redirect('/playlists');
  });
});

app.post('/playlists/delete', (req, res) => {
  const playlistId = req.body.playlistId;
  db.query('DELETE FROM Playlists WHERE playlistID = ?', [playlistId], (err) => {
    if (err) return res.status(500).send("Delete failed");
    res.redirect('/playlists');
  });
});

// PLAYLISTSONG ROUTES
app.get('/playlistsongs', (req, res) => {
  db.query(`
    SELECT ps.playlistID, ps.songID, p.title AS playlistTitle, s.title AS songTitle
    FROM PlaylistSong ps
    JOIN Playlists p ON ps.playlistID = p.playlistID
    JOIN Songs s ON ps.songID = s.songID
  `, (err, results) => {
    if (err) return res.status(500).send("Database error");
    res.render('playlistsongs', { playlistsongs: results });
  });
});

app.post('/playlistsongs/add', (req, res) => {
  const { playlistID, songID } = req.body;
  db.query('INSERT INTO PlaylistSong (playlistID, songID) VALUES (?, ?)', [playlistID, songID], (err) => {
    if (err) return res.status(500).send("Insert failed");
    res.redirect('/playlistsongs');
  });
});

app.post('/playlistsongs/delete', (req, res) => {
  const { playlistID, songID } = req.body;
  db.query('DELETE FROM PlaylistSong WHERE playlistID = ? AND songID = ?', [playlistID, songID], (err) => {
    if (err) return res.status(500).send("Delete failed");
    res.redirect('/playlistsongs');
  });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
