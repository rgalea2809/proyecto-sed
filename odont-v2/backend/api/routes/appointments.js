const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const checkAuth = require("../middleware/check-auth");

const Appointment = require("../models/appointment");

router.get("/", checkAuth, (req, res, next) => {
	Appointment.find()
		.exec()
		.then((docs) => {
			const response = {
				count: docs.length,
				appointments: docs.map((doc) => {
					return {
						id: doc._id,
						appointmentId: doc._id,
						doctorId: doc.doctorId,
						patientId: doc.patientId,
						date: doc.date,
						appointmentType: doc.appointmentType,
						medicine: doc.medicine,
						info: doc.info,
						treatmentId: doc.treatmentId,

						request: {
							type: "GET",
							url:
								"http://localhost:3000/appointments/" + doc._id,
						},
					};
				}),
			};

			console.log(docs);
			if (docs.length >= 0) {
				res.status(200).json(response);
			} else {
				res.status(404).json({ message: "No entries found" });
			}
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({
				error: err,
			});
		});
});

router.post("/", checkAuth, (req, res, next) => {
	const appointment = new Appointment({
		_id: new mongoose.Types.ObjectId(),
		doctorId: req.body.doctorId,
		patientId: req.body.patientId,
		date: req.body.date,
		appointmentType: req.body.appointmentType,
		medicine: req.body.medicine,
		info: req.body.info,
		treatmentId: req.body.treatmentId,
	});

	appointment
		.save()
		.then((result) => {
			console.log(result);
			res.status(201).json({
				message: "Created Appointment record successfully",
				createdAppointment: {
					doctorId: result.doctorId,
					patientId: result.patientId,
					_id: result._id,
					request: {
						type: "GET",
						url: "http://localhost:3000/appointments/" + result._id,
					},
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

router.get("/:appointmentId", checkAuth, (req, res, next) => {
	const id = req.params.appointmentId;

	Appointment.findById(id)
		.exec()
		.then((doc) => {
			console.log("From database ", doc);
			if (doc) {
				res.status(200).json({
					appointment: doc,
					request: {
						type: "GET",
						description: "Get certain appointment",
						url: "http://localhost:3000/appointments/" + id,
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

router.patch("/:appointmentId", checkAuth, (req, res, next) => {
	// Patching syntax
	// {"propName": "sex", "value": "Masc"}

	const id = req.params.appointmentId;
	const updateOps = {};

	console.log(req.body);

	for (const ops of req.body) {
		updateOps[ops.propName] = ops.value;
		console.log(ops.value);
	}

	Appointment.updateOne({ _id: id }, { $set: updateOps })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Updated appointment",
				request: {
					type: "PATCH",
					url: "http://localhost:3000/appointments/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
		});
});

router.delete("/:appointmentId", checkAuth, (req, res, next) => {
	const id = req.params.appointmentId;
	Appointment.remove({ _id: id })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Appointment Deleted",
				request: {
					type: "DELETE",
					url: "http://localhost:300/appointments/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

module.exports = router;
