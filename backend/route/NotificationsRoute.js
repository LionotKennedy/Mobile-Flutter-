const express = require("express");

const {
  createNotification,
  readNotification,
  editNotification,
  updateNotification,
  deleteNotification,
} = require("../controller/NotificationsController");

const router = express.Router();

router.route("/createNotif").post(createNotification);
router.route("/readNotif").get(readNotification);
router.route("/editNotif/:notiId").get(editNotification);
router.route("/updateNotif/:notiId").put(updateNotification);
router.route("/deleteNotif/:notiId").delete(deleteNotification);

module.exports = router;
