const Vol = require("../models/Vol");

// ############################## CREATING #################################//
const createVol = async (req, res, next) => {
  try {
    const {
      numVol,
      compagnieAerienne,
      heureArriveePrevue,
      heureDepartPrevue,
      status,
      pisteAssignee,
    } = req.body;
    console.log(numVol);
    console.log(compagnieAerienne);
    if (
      !numVol ||
      !compagnieAerienne ||
      !heureArriveePrevue ||
      !heureDepartPrevue ||
      !status ||
      !pisteAssignee
    ) {
      res.status(400).json({
        message: 400,
        message: "Please fill all required fields",
      });
    } else {
      const vol = new Vol({
        numVol,
        compagnieAerienne,
        heureArriveePrevue,
        heureDepartPrevue,
        status,
        pisteAssignee,
      });
      await vol.save();
      res.status(200).json({
        status: 200,
        data: vol,
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
const readVol = async (req, res, next) => {
  try {
    const vol = await Vol.find();
    res.status(200).json({
      status: 200,
      message: "Fetch all users from database",
      data: vol,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## EDITING #################################//
const editVol = async (req, res) => {
  try {
    const volId = req.params.volId;
    console.log(volId);

    // Trouver le document avec l'id correspondant
    const vol = await Vol.findOne({ _id: volId });

    // Si aucun document n'est trouvé, retourner une réponse d'erreur
    if (!vol) {
      return res.status(404).json({
        status: 404,
        message: "Vol not found",
      });
    }

    // Construire les données à retourner
    const volData = {
      numVol: vol.numVol,
      compagnieAerienne: vol.compagnieAerienne,
      heureArriveePrevue: vol.heureArriveePrevue,
      status: vol.status,
      pisteAssignee: vol.pisteAssignee,
      volId: vol._id,
    };

    return res.status(200).json({
      status: 200,
      message: "Fetched edited data",
      data: volData,
    });
  } catch (error) {
    return res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## UPDATING #################################//
const updateVol = async (req, res) => {
  const volId = req.params.volId;
  try {
    const {
      numVol,
      compagnieAerienne,
      heureArriveePrevue,
      heureDepartPrevue,
      status,
      pisteAssignee,
    } = req.body;
    const vol = await Vol.findById(volId);

    await vol.updateOne({ $set: req.body });

    res.status(200).json({
      status: 200,
      message: "Updated",
      data: vol,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## DELETING #################################//
const deleteVol = async (req, res) => {
  const volId = req.params.volId;
  try {
    const {
      numVol,
      compagnieAerienne,
      heureArriveePrevue,
      heureDepartPrevue,
      status,
      pisteAssignee,
    } = req.body;
    const vol = await Vol.findById(volId);
    await vol.deleteOne({ $set: req.body });
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

module.exports = { createVol, readVol, editVol, updateVol, deleteVol };
