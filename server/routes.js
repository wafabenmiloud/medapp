const express = require("express");
const router = express.Router();

const { register, login, profile, logout } = require("./api/user_api");
const {
  addAppointment,
  updateAppointment,
  getAppointment,
  deleteAppointment,
} = require("./api/appointment_api");

const {
  addReview,
  updateReview,
  deleteReview,
} = require("./api/review_api");
const { insertDoctors, getDoctors, dropDoctors,getDoctorByID } = require("./api/doctor_api");

router
  .route("/doctors")
  .get(getDoctors)
  .post(insertDoctors)
  .delete(dropDoctors);
router.get("/doctors/:id", getDoctorByID);

//user api
router.post("/register", register);
router.post("/login", login);
router.get("/profile", profile);

//appointment api
router.post("/addappoint", addAppointment);
router.put("/updateappoint/:id", updateAppointment);
router.get("/getappoint", getAppointment);
router.delete("/deleteappoint/:id", deleteAppointment);

//review api
router.post("/addreview/:id", addReview);
router.put("/updatereview/:id", updateReview);
router.delete("/deletereview/:id", deleteReview);

module.exports = router;
