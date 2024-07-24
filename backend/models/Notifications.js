const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema({
  type: {
    type: String,
    required: true,
  },
  message: {
    type: String,
    required: true,
  },
  dateHeure: {
    type: Date,
    default: Date.now,
  },
});

const Notification = mongoose.model("notification", notificationSchema);

module.exports = Notification;
