import Users from "../models/Users.js";
const signUpController=async(req,res)=>{
    const {email,pass}=req.body;
    const newUser=await Users.findOne({email});
    if(newUser){
         res.send("User already exists!");
    }
    else{
        const newu=await new Users({email,pass});
        newu.save();
         res.send("Sign up successfull:)");
    }
};
export default signUpController;