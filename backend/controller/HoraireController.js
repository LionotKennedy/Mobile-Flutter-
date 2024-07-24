const Horaire = require("../models/Horaire");

// ############################## CREATING #################################//
const createHoraire = async (req, res, next) => {
  try {
    const { pisteID, heureDebut, heureFin, volID } = req.body;
    console.log(pisteID);
    console.log(heureDebut);
    if (!pisteID || !heureDebut || !heureFin || !volID) {
      res.status(400).json({
        message: 400,
        message: "Please fill all required fields",
      });
    } else {
      const horaire = new Horaire({
        pisteID,
        heureDebut,
        heureFin,
        volID,
      });
      await horaire.save();
      res.status(200).json({
        status: 200,
        data: horaire,
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
const readHoraire = async (req, res, next) => {
  try {
    const hour = await Horaire.find();
    res.status(200).json({
      status: 200,
      message: "Fetch all users from database",
      data: hour,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## EDITING #################################//
const editHoraire = async (req, res) => {
  try {
    const hourId = req.params.hourId;
    console.log(hourId);

    // Trouver le document avec l'id correspondant
    const hour = await Horaire.findOne({ _id: hourId });

    // Si aucun document n'est trouvé, retourner une réponse d'erreur
    if (!hour) {
      return res.status(404).json({
        status: 404,
        message: "Hour not found",
      });
    }

    // Construire les données à retourner
    const hourData = {
      pisteID: hour.pisteID,
      heureDebut: hour.heureDebut,
      heureFin: hour.heureFin,
      volID: hour.volID,
      hourId: hour._id,
    };

    return res.status(200).json({
      status: 200,
      message: "Fetched edited data",
      data: hourData,
    });
  } catch (error) {
    return res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## UPDATING #################################//
const updateHoraire = async (req, res) => {
  const hourId = req.params.hourId;
  try {
    const { pisteID, heureDebut, heureFin, volID } = req.body;
    const hour = await Horaire.findById(hourId);

    await hour.updateOne({ $set: req.body });

    res.status(200).json({
      status: 200,
      message: "Updated",
      data: hour,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## DELETING #################################//
const deleteHoraire = async (req, res) => {
  const hourId = req.params.hourId;
  try {
    const { pisteID, heureDebut, heureFin, volID } = req.body;
    const hour = await Horaire.findById(hourId);
    await hour.deleteOne({ $set: req.body });
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
  createHoraire,
  readHoraire,
  editHoraire,
  updateHoraire,
  deleteHoraire,
};
