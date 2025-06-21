import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import allRoutes from "./routes/allRoutes.js";

dotenv.config();

mongoose.connect(process.env.MONGO_URI)
.then(()=>console.log("db connected"))  
.catch(()=>console.log("db not connected"));

const app=express();
app.use(express.json());
// app.get("/api",(req,res)=>{
//     console.log("req recieved at backend");
//     res.send("response from backend");
// });
app.use("/api",allRoutes);
app.listen(process.env.PORT,()=>{
    console.log("server running at "+process.env.PORT);
})