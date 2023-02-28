const dotenv = require("dotenv");
dotenv.config();
var jwt = require('jwt-simple')

const  User  = require("../model/user");


const register = async (req,res)=>{
    try{
        if ((!req.body.username) || (!req.body.email) || (!req.body.phone) || (!req.body.password)) {
            res.json({success: false, msg: 'Enter all fields'})
        }
        else {
            var newUser = User({
                username: req.body.username,
                email:req.body.email,
                phone:req.body.phone,
                password: req.body.password
            });
            newUser.save(function (err) {
                if (err) {
                    res.json({success: false, msg: 'Failed to save'})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    }catch{
        res.status(500).send({ message: "Internal Server Error" });
    }
}
const login = async (req,res)=>{
    try{
        User.findOne({
            email: req.body.email
        }, function (err, user) {
                if (err) throw err
                if (!user) {
                    res.status(403).send({success: false, msg: 'User not found'})
                }

                else {
                    user.comparePassword(req.body.password, function (err, isMatch) {
                        if (isMatch && !err) {
                            var token = jwt.encode(user, process.env.SECRET)
                            res.json({success: true, token: token})
                        }
                        else {
                            return res.status(403).send({success: false, msg: 'Wrong password'})
                        }
                    })
                }
        }
        )
    }catch{
        res.status(500).send({ message: "Internal Server Error" });
    }
}
const profile = async (req,res)=>{
    try{
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, process.env.SECRET)
            var msg = {
                "username": decodedtoken.username,
                "email":decodedtoken.email,
                "phone":decodedtoken.phone
            }
            return res.json({success: true, msg: msg})
        }
        else {
            return res.json({success: false, msg: 'No Headers'})
        }
    
    }catch{
        res.status(500).send({ message: "Internal Server Error" });
    }
}
const logout = async (req,res) =>{
    try {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, process.env.SECRET)
            
            // Set token expiration to a past date to invalidate it
            decodedtoken.exp = 1;
            
            res.json({success: true, msg: 'Logout successful'})
        }
        else {
            return res.json({success: false, msg: 'No Headers'})
        }
    } catch {
        res.status(500).send({ message: "Internal Server Error" });
    }
}


module.exports = {
   register,
   login,
   profile,
   logout
  };