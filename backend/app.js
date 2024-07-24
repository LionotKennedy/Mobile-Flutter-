//################ From Modules ################//
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv");

//################ Variable ################//
const app = express();

//################ Middleware ################//
app.use(bodyParser.json({ limit: "30mb", extended: true }));
app.use(bodyParser.urlencoded({ limit: "30mb", extended: true }));
app.use(cors());
dotenv.config();

//################ Files Import ################//
const Auth = require("./route/UserRoute");
const Ring = require("./route/PisteRoute");
const Vol = require("./route/VolRoute");
const Hour = require("./route/HoraireRoute");
const Replace = require("./route/MaintenanceRoute");
const notification = require("./route/NotificationsRoute");

//################ From Envirement ################//
const CONNECTION = process.env.MONGODB_CONNECTION;
const PORT = process.env.PORT;

const connecting = mongoose.connect(CONNECTION);

//################ Anathers ################//
if (connecting != null) {
  console.log("Connexion stabled");
} else {
  console.log("Connexion failded");
}

//################ Route ################//
app.use("/auth", Auth);
app.use("/piste", Ring);
app.use("/vol", Vol);
app.use("/time", Hour);
app.use("/settings", Replace);
app.use("/notification", notification);

app.listen(PORT, () => {
  console.log(`Serveur démarré sur le port http://10.0.0.1:${PORT}`);
});
