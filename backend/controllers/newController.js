import Notes from "../models/Notes.js";
const newController=async(req,res)=>{
    try{
    const {email,title,content}=req.body;
    console.log(email);
    console.log(title);
    console.log(content);
    let exist=await Notes.findOne({email});
    const newNote = {
            title: title,
            content: content
        };
    if(!exist)
    {
        exist=new Notes({email,notes: [newNote]});
    }
    else{
        await exist.notes.push(newNote);
    }
    await exist.save();
    res.send("success");
    }
    catch(e)
    {
        res.send("backend error in adding");
    }

};
export default newController;