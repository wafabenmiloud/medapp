const express = require('express')
const cors = require('cors')
const passport = require('passport')
const bodyParser = require('body-parser')
const dotenv = require('dotenv');

const Connection = require('./config/db')
const router = require('./routes')

dotenv.config();
const app = express();
app.use(cors())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

//ROUTER
app.use('/', router);

//passport
app.use(passport.initialize())
require('./config/passport')(passport)

//db
MONGODB_URI=process.env.MONGODB_URI
Connection(MONGODB_URI)

// server
const PORT = process.env.PORT || 4000
app.listen(PORT, console.log(`Server running on port ${PORT}`))
