import Notes from "../models/Notes.js"
const fetchNotesController=async(req,res)=>{
    try{
    const {email}=req.body;
    const exist=await Notes.findOne({email});
    if (exist && exist.notes && exist.notes.length > 0) {
      res.status(200).json(exist.notes); 
    }
    else
    {
    console.log("inside else");
        res.status(200).json([]);
        
    }
    }
    catch(e)
    {
        console.log("inside catch");
        res.status(500).json("backend problem in fetchinf notes");
        
    }
}
export default fetchNotesController;