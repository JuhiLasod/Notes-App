import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app=express();
app.get("/api",(req,res)=>{
    console.log("req recieved at backend");
    res.send("response from backend");
});

app.listen(process.env.PORT,()=>{
    console.log("server running at "+process.env.PORT);
})