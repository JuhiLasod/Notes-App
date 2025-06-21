import mongoose from "mongoose";

const userSchema= mongoose.Schema({
    email: {type: String},
    pass: {type: String}
});

export default mongoose.model('users',userSchema,"users");