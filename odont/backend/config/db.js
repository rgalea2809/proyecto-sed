import mongoose from "mongoose";
import "./backend/config/db.js";

const connectDB = async () => {
	try {
		//database Name
		const databaseName = "odont";
		const con = await mongoose.connect(
			`mongodb://localhost:27017/${databaseName}`,
			{
				useNewUrlParser: true,
				useUnifiedTopology: true,
				useCreateIndex: true,
			}
		);
		console.log(`Database connected : ${con.connection.host}`);
	} catch (error) {
		console.error(`Error: ${error.message}`);
		process.exit(1);
	}
};

export default connectDB;
