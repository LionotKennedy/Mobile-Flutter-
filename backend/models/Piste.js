const mongoose = require("mongoose");

const pisteSchema = mongoose.Schema({
  pisteName: {
    type: String,
    required: true,
  },
  pisteStatus: {
    type: String,
    required: true,
  },
});

const Piste = mongoose.model("piste", pisteSchema);

module.exports =  Piste ;
