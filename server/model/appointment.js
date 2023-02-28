const mongoose = require('mongoose');
const {Schema} = mongoose;

const AppointmentSchema = new Schema({
  doctorname: {
      type: String,
      require: true
  },
  date: {
    type: Date ,
    require: true
},
time: {
  type: String,
  required: true
},
author:{type:Schema.Types.ObjectId, ref:'users'},

})


module.exports = mongoose.model('appointments', AppointmentSchema)
