const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
  doctor_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "doctors",
  },
  created_at: {
    type: Date,
    default: Date.now(),
  },
  author: { type: mongoose.Schema.Types.ObjectId, ref: "users" },
  review: String,
  rate: Number,
});

module.exports = mongoose.model('reviews', reviewSchema)
