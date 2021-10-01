const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const checkAuth = require("../middleware/check-auth");

const Treatment = require("../models/treatment");

router.get("/", checkAuth, (req, res, next) => {
	Treatment.find()
		.exec()
		.then((docs) => {
			const response = {
				count: docs.length,
				treatments: docs.map((doc) => {
					return {
						id: doc._id,
						treatmentId: doc._id,
						doctorId: doc.doctorId,
						patientId: doc.patientId,
						dateOfCreation: doc.dateOfCreation,
						appointments: doc.appointments,
						totalCost: doc.totalCost,
						payed: doc.payed,

						request: {
							type: "GET",
							url: "http://localhost:3000/treatments/" + doc._id,
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
	const treatment = new Treatment({
		_id: new mongoose.Types.ObjectId(),
		doctorId: req.body.doctorId,
		patientId: req.body.patientId,
		dateOfCreation: req.body.dateOfCreation,
		appointments: req.body.appointments,
		totalCost: req.body.totalCost,
		payed: req.body.payed,
	});

	treatment
		.save()
		.then((result) => {
			console.log(result);
			res.status(201).json({
				message: "Created Treatment successfully",
				createdTreatment: {
					id: result._id,
					treatmentId: result._id,
					_id: result._id,
					request: {
						type: "GET",
						url: "http://localhost:3000/treatments/" + result._id,
					},
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

router.get("/:treatmentId", checkAuth, (req, res, next) => {
	const id = req.params.treatmentId;

	Treatment.findById(id)
		.exec()
		.then((doc) => {
			console.log("From database ", doc);
			if (doc) {
				res.status(200).json({
					treatment: doc,
					request: {
						type: "GET",
						description: "Get certain treatment",
						url: "http://localhost:3000/treatments/" + id,
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

router.patch("/:treatmentId", checkAuth, (req, res, next) => {
	// Patching syntax
	// {"propName": "sex", "value": "Masc"}

	const id = req.params.treatmentId;
	const updateOps = {};

	console.log(req.body);

	for (const ops of req.body) {
		updateOps[ops.propName] = ops.value;
		console.log(ops.value);
	}

	Treatment.updateOne({ _id: id }, { $set: updateOps })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Updated treatment",
				request: {
					type: "PATCH",
					url: "http://localhost:3000/treatments/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
		});
});

router.delete("/:treatmentId", checkAuth, (req, res, next) => {
	const id = req.params.treatmentId;
	Treatment.remove({ _id: id })
		.exec()
		.then((result) => {
			res.status(200).json({
				message: "Treatment Deleted",
				request: {
					type: "DELETE",
					url: "http://localhost:300/treatments/" + id,
				},
			});
		})
		.catch((err) => {
			console.log(err);
			res.status(500).json({ error: err });
		});
});

module.exports = router;
