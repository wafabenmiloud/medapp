const mongoose = require("mongoose");

const doctorModel = new mongoose.Schema({
  name: String,
  speciality: String,
  city: String,
  location: String,
  review_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "reviews",
  },
  createdAt: { type: Date, default: Date.now },
});
const Doctor = mongoose.model("doctors", doctorModel);
module.exports = {Doctor};