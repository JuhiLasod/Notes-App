import express from "express";
import loginController from "../controllers/loginController.js";
import signUpController from "../controllers/signUpController.js";
import newController from "../controllers/newController.js";
const allRoutes= express.Router();
allRoutes.post("/login",loginController);
allRoutes.post("/signup",signUpController);
allRoutes.post("/new",newController);
export default allRoutes;