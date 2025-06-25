import Notes from "../models/Notes.js";

const deleteController=async(req,res)=>{
    try{
        const {email,title,content}=req.body;
        const del= await Notes.updateOne(
            {email},
            {
                $pull:{
                    notes:{title, content}
                }
            }
        )
        if(del.modifiedCount>0)
        {
            res.send("successfully deleted");
        }
        else{
            res.send("not able to delete this particular note");
        }
    }
    catch(e)
    {
        res.send("Not able to delete currently");
    }
}
export default deleteController;