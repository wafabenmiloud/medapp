const mongoose = require('mongoose');
const {Schema, model} = mongoose;
var bcrypt = require('bcrypt')

const userSchema = new Schema({
  username: {
      type: String,
      require: true
  },
  email: {
    type: String,
    require: true
},
phone: {
  type: Number,
  require: true
},
  password: {
      type: String,
      require: true
  }
})
userSchema.pre('save', function (next) {
  var user = this;
  if (this.isModified('password') || this.isNew) {
      bcrypt.genSalt(10, function (err, salt) {
          if (err) {
              return next(err)
          }
          bcrypt.hash(user.password, salt, function (err, hash) {
              if (err) {
                  return next(err)
              }
              user.password = hash;
              next()
          })
      })
  }
  else {
      return next()
  }
})
userSchema.methods.comparePassword = function (passw, cb) {
  bcrypt.compare(passw, this.password, function (err, isMatch) {
      if(err) {
          return cb(err)
      }
      cb(null, isMatch)
  })
}
module.exports = mongoose.model('users', userSchema)
