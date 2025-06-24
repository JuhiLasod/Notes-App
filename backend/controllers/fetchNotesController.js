import Notes from "../models/Notes.js"
const fetchNotesController=async(req,res)=>{
    try{
    const {email}=req.body;
    const exist=await Notes.findOne({email});
    if(exist)
    {
        console.log("inside if");
        res.status(200).json("some notes fpund for this email")
    }
    else
    {
    console.log("inside else");
        res.status(200).json("no notes found");
        
    }
    }
    catch(e)
    {
        console.log("inside catch");
        res.status(500).json("backend problem in fetchinf notes");
        
    }
}
export default fetchNotesController;