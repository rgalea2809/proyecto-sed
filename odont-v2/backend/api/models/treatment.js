const { Decimal128 } = require("bson");
const mongoose = require("mongoose");

const treatmentSchema = mongoose.Schema({
	_id: mongoose.Schema.Types.ObjectId,
	doctorId: { type: String, required: true },
	patientId: {
		type: String,
		required: true,
	},
	treatmentName: {
		type: String,
		required: true,
	},
	dateOfCreation: {
		type: Date,
		required: true,
	},
	appointments: [
		{
			type: String,
		},
	],
});

module.exports = mongoose.model("Treatment", treatmentSchema);
