const { Decimal128 } = require("bson");
const mongoose = require("mongoose");

const doctorSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: String,
    lastName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
});

module.exports = mongoose.model("Doctor", doctorSchema);
