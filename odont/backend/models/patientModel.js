import { Double } from "bson";
import mongoose from "mongoose";

const patientSchema = mongoose.Schema({
	_id: mongoose.Schema.Types.ObjectId,
	name: {
		type: String,
		required: true,
	},
	lastName: {
		type: String,
		required: true,
	},
	birthDate: {
		type: Date,
		required: true,
	},

	weight: {
		type: Double,
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
		unique: true,
	},
	phone: {
		type: String,
		required: true,
		unique: true,
	},
});

module.exports = mongoose.model("Patient", patientSchema);
