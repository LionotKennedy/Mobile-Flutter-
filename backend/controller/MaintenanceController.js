const Maintenance = require("../models/Maintenance");

// ############################## CREATING #################################//
const createMaintenance = async (req, res, next) => {
  try {
    const { pisteID, typeMaintenance, dateDebut, dateFin, description } =
      req.body;
    console.log(pisteID);
    console.log(typeMaintenance);
    if (
      !pisteID ||
      !typeMaintenance ||
      !dateDebut ||
      !dateFin ||
      !description
    ) {
      res.status(400).json({
        message: 400,
        message: "Please fill all required fields",
      });
    } else {
      const maintenance = new Maintenance({
        pisteID,
        typeMaintenance,
        dateDebut,
        dateFin,
        description,
      });
      await maintenance.save();
      res.status(200).json({
        status: 200,
        data: maintenance,
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
const readMaintenance = async (req, res, next) => {
  try {
    const maintenance = await Maintenance.find();
    res.status(200).json({
      status: 200,
      message: "Fetch all users from database",
      data: maintenance,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## EDITING #################################//
const editMaintenance = async (req, res) => {
  try {
    const maintId = req.params.maintId;
    console.log(maintId);

    // Trouver le document avec l'id correspondant
    const mainte = await Maintenance.findOne({ _id: maintId });

    // Si aucun document n'est trouvé, retourner une réponse d'erreur
    if (!mainte) {
      return res.status(404).json({
        status: 404,
        message: "Maintenance not found",
      });
    }

    // Construire les données à retourner
    const maintenanceData = {
      pisteID: mainte.pisteID,
      typeMaintenance: mainte.typeMaintenance,
      dateDebut: mainte.dateDebut,
      dateFin: mainte.dateFin,
      description: mainte.description,
      maintId: mainte._id,
    };

    return res.status(200).json({
      status: 200,
      message: "Fetched edited data",
      data: maintenanceData,
    });
  } catch (error) {
    return res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## UPDATING #################################//
const updateMaintenance = async (req, res) => {
  const maintId = req.params.maintId;
  try {
    const { pisteID, typeMaintenance, dateDebut, dateFin, description } =
      req.body;
    const maintenance = await Maintenance.findById(maintId);

    await maintenance.updateOne({ $set: req.body });

    res.status(200).json({
      status: 200,
      message: "Updated",
      data: maintenance,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## DELETING #################################//
const deleteMaintenance = async (req, res) => {
  const maintId = req.params.maintId;
  try {
    const { pisteID, typeMaintenance, dateDebut, dateFin, description } =
      req.body;
    const maintenance = await Maintenance.findById(maintId);
    await maintenance.deleteOne({ $set: req.body });
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
  createMaintenance,
  readMaintenance,
  editMaintenance,
  updateMaintenance,
  deleteMaintenance,
};
