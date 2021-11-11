const { Decimal128 } = require("bson");
const mongoose = require("mongoose");

const patientSchema = mongoose.Schema({
	_id: mongoose.Schema.Types.ObjectId,
	name: String,
	lastName: {
		type: String,
		required: true,
	},
	birthDate: {
		type: Date,
		required: true,
	},

	weight: {
		type: Decimal128,
		required: true,
	},
	sex: {
		type: String,
		required: true,
	},

	medicalConditions: [
		{
			type: String,
		},
	],
	email: {
		type: String,
		required: true,
	},
	phone: {
		type: String,
		required: true,
	},
});

module.exports = mongoose.model("Patient", patientSchema);
