const { Decimal128 } = require("bson");
const mongoose = require("mongoose");

const appointmentSchema = mongoose.Schema({
	_id: mongoose.Schema.Types.ObjectId,
	doctorId: { type: String, required: true },
	patientId: {
		type: String,
		required: true,
	},
	date: {
		type: Date,
		required: true,
	},
	info: {
		type: String,
		required: true,
	},
	treatmentId: String,
});

module.exports = mongoose.model("Appointment", appointmentSchema);
