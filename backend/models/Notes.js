import mongoose, { Schema } from "mongoose";
const innerSchema=new mongoose.Schema({
    title: {type: String},
    content: {type:String},
    createdAt: {
        type: Date,
        default: Date.now
    }
});
const notesSchema= new mongoose.Schema({
    email: {type: String},
    notes: [innerSchema]
});
export default mongoose.model('Notes',notesSchema);