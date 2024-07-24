const Notification = require("../models/Notifications");

// ############################## CREATING #################################//
const createNotification = async (req, res, next) => {
  try {
    const { type, message, dateHeure } = req.body;
    console.log(type);
    console.log(message);
    if (!type || !message || !dateHeure) {
      res.status(400).json({
        message: 400,
        message: "Please fill all required fields",
      });
    } else {
      const notification = new Notification({
        type,
        message,
        dateHeure,
      });
      await notification.save();
      res.status(200).json({
        status: 200,
        data: notification,
        message: "Success",
      });
    }
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## READING #################################//
const readNotification = async (req, res, next) => {
  try {
    const notification = await Notification.find();
    res.status(200).json({
      status: 200,
      message: "Fetch all users from database",
      data: notification,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## EDITING #################################//
const editNotification = async (req, res) => {
  try {
    const notiId = req.params.notiId;
    console.log(notiId);

    // Trouver le document avec l'id correspondant
    const notification = await Notification.findOne({ _id: notiId });

    // Si aucun document n'est trouvé, retourner une réponse d'erreur
    if (!notification) {
      return res.status(404).json({
        status: 404,
        message: "Maintenance not found",
      });
    }

    // Construire les données à retourner
    const notificationData = {
      type: notification.type,
      message: notification.message,
      dateHeure: notification.dateHeure,
      notiId: notification._id,
    };

    return res.status(200).json({
      status: 200,
      message: "Fetched edited data",
      data: notificationData,
    });
  } catch (error) {
    return res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## UPDATING #################################//
const updateNotification = async (req, res) => {
  const notiId = req.params.notiId;
  try {
    const { type, message, dateHeure } = req.body;
    const notification = await Notification.findById(notiId);

    await notification.updateOne({ $set: req.body });

    res.status(200).json({
      status: 200,
      message: "Updated",
      data: notification,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## DELETING #################################//
const deleteNotification = async (req, res) => {
  const notiId = req.params.notiId;
  try {
    const { type, message, dateHeure } = req.body;
    const notification = await Notification.findById(notiId);
    await notification.deleteOne({ $set: req.body });
    res.status(200).json({
      status: 200,
      message: "deleted",
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

module.exports = {
  createNotification,
  readNotification,
  editNotification,
  updateNotification,
  deleteNotification,
};
