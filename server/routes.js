const express = require('express');
const router = express.Router();

const {register,  login,  profile, logout} = require('./api/user_api');
const {addAppointment,updateAppointment,getAppointment,deleteAppointment} = require('./api/appointment_api');
//user api
router.post('/register', register );
router.post('/login', login)
router.get('/profile', profile)

//appointment api
router.post('/addappoint', addAppointment);
router.put('/updateappoint/:id', updateAppointment);
router.get('/getappoint',getAppointment);
router.delete('/deleteappoint/:id',deleteAppointment);



//review api



module.exports = router;
