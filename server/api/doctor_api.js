const {Doctor} = require('../model/doctor');
const {doctors} = require("../config/doctors");
const Review = require("../model/review");

/** get all doctors */
const getDoctors = async (req, res) => {
  try {
    const doctors = await Doctor.find();
    res.json({ msg: "Doctors found successfully!", data: doctors });
  } catch (error) {
    res.json({ error });
  }
};
const getDoctorByID = async (req, res) => {
  const { id } = req.params;

  const doctor = await Doctor.findById(id);
  const reviews = await Review.find({ doctor_id: id })
    .populate("author", ["username"])
    .sort({ created_at: -1 })
    .lean();

  res.json({
    doctor,
    reviews,
  });
};
  /** insert all doctors */
  const insertDoctors = async (req, res) => {
    try {
      const result = await Doctor.insertMany(doctors);
      res.json({ msg: "Data Saved Successfully...!", data: result });
    } catch (error) {
      res.json({ error });
    }
  };
  
  /** Delete all doctors */
  const dropDoctors = async (req, res) => {
    try {
      const result = await Doctor.deleteMany();
      res.json({ msg: "All doctors deleted successfully!", data: result });
    } catch (error) {
      res.json({ error });
    }
  };
  

  module.exports = {
   insertDoctors,
   getDoctors,
   dropDoctors,
   getDoctorByID
   };