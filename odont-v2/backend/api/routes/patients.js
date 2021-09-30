const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");

const Patient = require("../models/patient");

router.get("/", (req, res, next) => {
	Patient.find()
		.exec()
		.then((docs) => {
			const response = {
				count: docs.length,
				patients: docs.map((doc) => {
					return {
						name: doc.name,
						lastName: doc.lastName,
						_id: doc._id,
						birthDate: doc.birthDate,
						weight: doc.weight,
						phone: doc.phone,
						email: doc.email,
						medicalConditions: doc.medicalConditions,
						sex: doc.sex,

						request: {
							type: "GET",
							url: "http://localhost:3000/patients/" + doc._id,
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

router.post("/", (req, res, next) => {
	const patient = new Patient({
		_id: new mongoose.Types.ObjectId(),
		name: req.body.name,
		lastName: req.body.lastName,
		birthDate: req.body.birthDate,
		weight: req.body.weight,
		sex: req.body.sex,
		medicalConditions: req.body.medicalConditions,
		email: req.body.email,
		phone: req.body.phone,
	});

	patient
		.save()
		.then((result) => {
			console.log(result);
			res.status(201).json({
				message: "Created Patient successfully",
				createdProduct: {
					name: result.name,
					lastName: result.lastName,
					_id: result._id,
					request: {
						type: "GET",
						url: "http://localhost:3000/patients/" + result._id,
					},
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

router.get("/:patientId", (req, res, next) => {
	const id = req.params.patientId;

	Patient.findById(id)
		.exec()
		.then((doc) => {
			console.log("From database ", doc);
			if (doc) {
				res.status(200).json({
					patient: doc,
					request: {
						type: "GET",
						description: "Get certain patient",
						url: "http://localhost:3000/patients/id",
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

router.patch("/:patientId", (req, res, next) => {
	const id = req.params.patientId;
	const updateOps = {};

	console.log(req.body);

	for (const ops of req.body) {
		updateOps[ops.propName] = ops.value;
		console.log(ops.value);
	}

	Product.updateOne({ _id: id }, { $set: updateOps })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Updated patient",
				request: {
					type: "PATCH",
					url: "http://localhost:3000/patients/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
		});
});

router.delete("/:patientId", (req, res, next) => {
	const id = req.params.patientId;
	Patient.remove({ _id: id })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Patient Deleted",
				request: {
					type: "DELETE",
					url: "http://localhost:300/patients/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

module.exports = router;
