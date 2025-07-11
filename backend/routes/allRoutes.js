import express from "express";
import loginController from "../controllers/loginController.js";
import signUpController from "../controllers/signUpController.js";
import newController from "../controllers/newController.js";
import fetchNotesController from "../controllers/fetchNotesController.js";
import deleteController from "../controllers/deleteController.js";
const allRoutes= express.Router();
allRoutes.post("/login",loginController);
allRoutes.post("/signup",signUpController);
allRoutes.post("/new",newController);
allRoutes.post("/delete",deleteController);
allRoutes.post("/fetch-notes",fetchNotesController);
export default allRoutes;