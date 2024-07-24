const Piste = require("../models/Piste");

// ############################## CREATING #################################//
const createPiste = async (req, res, next) => {
  try {
    const { pisteName, pisteStatus } = req.body;
    console.log(pisteName);
    console.log(pisteStatus);
    if (!pisteName || !pisteStatus) {
      res.status(400).json({
        message: 400,
        message: "Please fill all required fields",
      });
    } else {
      const piste = new Piste({ pisteName, pisteStatus });
      await piste.save();
      res.status(200).json({
        status: 200,
        data: piste,
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
const getPiste = async (req, res) => {
  try {
    const pistes = await Piste.find();
    res.status(200).json({
      status: 200,
      message: "Fetch all users from database",
      data: pistes,
    });
  } catch (error) {
    res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## EDITING #################################//
const editPiste = async (req, res) => {
  try {
    const pisteId = req.params.pisteId;
    console.log(pisteId);

    // Trouver le document avec l'id correspondant
    const piste = await Piste.findOne({ _id: pisteId });

    // Si aucun document n'est trouvé, retourner une réponse d'erreur
    if (!piste) {
      return res.status(404).json({
        status: 404,
        message: "Piste not found",
      });
    }

    // Construire les données à retourner
    const pistesData = {
      pisteName: piste.pisteName,
      pisteStatus: piste.pisteStatus,
      pisteId: piste._id,
    };

    return res.status(200).json({
      status: 200,
      message: "Fetched edited data",
      data: pistesData,
    });
  } catch (error) {
    return res.status(400).json({
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## UPDATING #################################//
const updatePiste = async (req, res) => {
  const pisteId = req.params.pisteId;
  try {
    const { pisteName, pisteStatus } = req.body;
    const piste = await Piste.findById(pisteId);
    // if (piste.Piste)
    await piste.updateOne({ $set: req.body });
    res.status(200).json({
      status: 200,
      message: "Updated",
      data: piste,
    });
  } catch (error) {
    res.status(400).json({
      status: 400,
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

// ############################## DELETING #################################//
const deletePiste = async (req, res) => {
  const pisteId = req.params.pisteId;
  try {
    const { pisteName, pisteStatus } = req.body;
    const piste = await Piste.findById(pisteId);
    await piste.deleteOne({ $set: req.body });
    res.status(200).json({
      status: 200,
      message: "deleted",
    });
  } catch (error) {
    res.status(400).json({
      status: 400,
      message: error.message,
    });
  }
};
// ############################## ENDING #################################//

module.exports = { createPiste, getPiste, editPiste, updatePiste, deletePiste };
