import express from "express";
import loginController from "../controllers/loginController.js";
import signUpController from "../controllers/signUpController.js";
const allRoutes= express.Router();
allRoutes.post("/login",loginController);
allRoutes.post("/signup",signUpController);
export default allRoutes;