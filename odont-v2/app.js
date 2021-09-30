const express = require("express");
const app = express();
const morgan = require("morgan");
const mongoose = require("mongoose");

const patientRoutes = require("./backend/api/routes/patients");
//const orderRoutes = require("./api/routes/orders");

mongoose
	.connect("mongodb://localhost:27017/odont", {
		useNewUrlParser: true,
		useUnifiedTopology: true,
	})
	.catch((err) => {
		console.log(err);
	});

mongoose.Promise = global.Promise;

app.use(morgan("dev"));
app.use(
	express.urlencoded({
		extended: false,
	})
);
app.use(express.json());

app.use((req, res, next) => {
	res.header("Access-Control-Allow-Origin", "*");
	res.header(
		"Access-Control-Allow-Headers",
		"Origin, X-Requested-With, Content-Type, Accept, Authorization"
	);
	if (req.method === "OPTIONS") {
		res.header(
			"Access-Control-Allow-Methods",
			"PUT, POST, PATCH, DELETE, GET"
		);
		return res.status(200).json({});
	}
	next();
});

//Routes
app.use("/patients", patientRoutes);

//app.use("/orders", orderRoutes);

app.use((req, res, next) => {
	const error = new Error("Route not found");
	error.status = 404;
	next(error);
});

app.use((error, req, res, next) => {
	res.status(error.status || 500);
	res.json({
		error: {
			message: error.message,
		},
	});
});

module.exports = app;
