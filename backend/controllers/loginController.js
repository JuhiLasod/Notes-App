import Users from "../models/Users.js";

const loginController=async(req,res)=>{
    const {email,pass}=req.body;
    const exist=await Users.findOne({email,pass});
    if(exist)
    {
        res.send("success");
    }
    else
    {
        res.send("invalid credentials");
    }
};
export default loginController;