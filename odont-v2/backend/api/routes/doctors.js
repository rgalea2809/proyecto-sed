const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const checkAuth = require("../middleware/check-auth");

const Doctor = require("../models/doctor");

// Return all doctors
router.get("/", (req, res, next) => {
	Doctor.find()
		.exec()
		.then((docs) => {
			const response = {
				count: docs.length,
				patients: docs.map((doc) => {
					return {
						name: doc.name,
						lastName: doc.lastName,
						_id: doc._id,
						email: doc.email,

						request: {
							type: "GET",
							url: "http://localhost:3000/doctors/" + doc._id,
						},
					};
				}),
			};

			console.log(docs);
			if (docs.length >= 0) {
				res.status(200).json(response);
			} else {
				res.status(404).json({ message: "No Doctors found" });
			}
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({
				error: err,
			});
		});
});

// Sign up doctors
router.post("/signup", (req, res, next) => {
	Doctor.find({ email: req.body.email })
		.exec()
		.then((user) => {
			if (user.length >= 1) {
				return res.status(409).json({
					message: "Mail Exists",
				});
			} else {
				bcrypt.hash(req.body.password, 10, (err, hash) => {
					if (err) {
						return res.status(500).json({
							error: err,
						});
					} else {
						const doctor = new Doctor({
							_id: new mongoose.Types.ObjectId(),
							name: req.body.name,
							lastName: req.body.lastName,
							email: req.body.email,
							password: hash,
						});

						doctor
							.save()
							.then((result) => {
								console.log(result);
								res.status(201).json({
									message: "Signed up doctor succesfully!",
									createdDoctor: {
										name: result.name,
										lastName: result.lastName,
										email: result.email,
										_id: result._id,
										request: {
											type: "GET",
											url:
												"http://localhost:3000/doctors/" +
												result._id,
										},
									},
								});
							})
							.catch((err) => {
								console.log(err);
								res.status(500).json({ error: err });
							});
					}
				});
			}
		});
});

// Log In a doctor
router.post("/login", (req, res, next) => {
	Doctor.find({ email: req.body.email })
		.exec()
		.then((doctor) => {
			if (doctor.length < 1) {
				return res.status(401).json({
					message: "Auth failed",
				});
			}

			bcrypt.compare(
				req.body.password,
				doctor[0].password,
				(err, result) => {
					if (err) {
						return res.status(401).json({
							message: "Auth failed",
						});
					}
					if (result) {
						// Log in successful
						const token = jwt.sign(
							{
								email: doctor[0].email,
								doctorId: doctor[0]._id,
							},
							process.env.JWT_KEY,
							{
								expiresIn: "24h",
							}
						);

						return res.status(200).json({
							message: "Auth Successful",
							token: token,
						});
					}
					res.status(401).json({
						message: "Auth failed",
					});
				}
			);
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

// return x doctor
router.get("/:doctorId", (req, res, next) => {
	const id = req.params.doctorId;

	Doctor.findById(id)
		.exec()
		.then((doc) => {
			console.log("From database ", doc);
			if (doc) {
				res.status(200).json({
					doctor: doc,
					request: {
						type: "GET",
						description: "Get certain doctor",
						url: "http://localhost:3000/doctor/" + id,
					},
				});
			} else {
				res.status(400).json({ message: "no valid entry found" });
			}
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

// delete x doctor
router.delete("/:doctorId", (req, res, next) => {
	const id = req.params.doctorId;

	Doctor.remove({ _id: id })
		.exec()
		.then((result) => {
			res.status(200).json({ message: "Doctor Deleted Successfully" });
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({
				error: err,
			});
		});
});

module.exports = router;
