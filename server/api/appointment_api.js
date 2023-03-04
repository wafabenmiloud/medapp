const fs = require("fs");
const dotenv = require("dotenv");
dotenv.config();
const jwt = require("jsonwebtoken");

const Appointment = require("../model/appointment");

const addAppointment = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);

      const { doctorname, date, time } = req.body;
      const appointmentDoc = await Appointment.create({
        doctorname,
        date,
        time,
        author: decodedtoken._id,
      });
      res.json(appointmentDoc);
    }
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};
const updateAppointment = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);
    }
    const id = req.params.id;
    const { date, time } = req.body;
    const appointmentDoc = await Appointment.findById(id);
    const isAuthor =
      JSON.stringify(appointmentDoc.author) ===
      JSON.stringify(decodedtoken._id);
    if (!isAuthor) {
      return res.status(400).json("you are not the author");
    }
    await appointmentDoc.updateOne({
      date,
      time,
    });

    res.json(appointmentDoc);
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};
const getAppointment = async (req, res) => {
  if (
    req.headers.authorization &&
    req.headers.authorization.split(" ")[0] === "Bearer"
  ) {
    var token = req.headers.authorization.split(" ")[1];
    var decodedtoken = jwt.decode(token, process.env.SECRET);
  }
  const now = new Date();
  const completedAppointments = await Appointment.find({
    author: decodedtoken._id,
    date: { $lt: now },
  });
  const upcomingAppointments = await Appointment.find({
    author: decodedtoken._id,
    date: { $gte: now },
  });
  res.json({
    completedAppointments: completedAppointments,
    upcomingAppointments: upcomingAppointments,
  });
};
const deleteAppointment = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);
    }

    const  id  = req.params.id;
    const appointmentDoc = await Appointment.findById(id);    
    const isAuthor =
      JSON.stringify(appointmentDoc.author) ===
      JSON.stringify(decodedtoken._id);
    if (!isAuthor) {
      return res.status(400).json("you are not the author");
    }
    await appointmentDoc.delete();

    res.json({ message: "Appointment deleted successfully" });
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};



module.exports = {
  addAppointment,
  updateAppointment,
  getAppointment,
  deleteAppointment
  
};
