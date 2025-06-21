import express from "express";
import loginController from "../controllers/loginController.js";
const allRoutes= express.Router();
allRoutes.post("/login",loginController);
export default allRoutes;