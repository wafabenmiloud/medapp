const dotenv = require("dotenv");
dotenv.config();
const jwt = require("jsonwebtoken");

const Review = require("../model/review");

const addReview = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);
      const { id } = req.params;
      const { review, rate } = req.body;
      const reviewDoc = await Review.create({
        doctor_id:id,
        review,
        rate,
        author: decodedtoken._id,
      });
      res.json(reviewDoc);
    }
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};
const updateReview = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);
    }
    const id = req.params.id;
    const { review, rate } = req.body;
    const reviewDoc = await Review.findById(id);
    const isAuthor =
      JSON.stringify(reviewDoc.author) ===
      JSON.stringify(decodedtoken._id);
    if (!isAuthor) {
      return res.status(400).json("you are not the author");
    }
    await reviewDoc.updateOne({
      review, rate
    });

    res.json(reviewDoc);
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};
const deleteReview = async (req, res) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.split(" ")[0] === "Bearer"
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decodedtoken = jwt.decode(token, process.env.SECRET);
    }

    const  id  = req.params.id;
    const reviewDoc = await Review.findById(id);    
    const isAuthor =
      JSON.stringify(reviewDoc.author) ===
      JSON.stringify(decodedtoken._id);
    if (!isAuthor) {
      return res.status(400).json("you are not the author");
    }
    await reviewDoc.delete();

    res.json({ message: "Review deleted successfully" });
  } catch (err) {
    console.error(err);
    res.status(401).json({ errorMessage: "Unauthorized" });
  }
};



module.exports = {
  addReview,
  updateReview,
  deleteReview
  
};
