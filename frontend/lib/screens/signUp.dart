import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './home.dart';
class signUp extends StatefulWidget{
  const signUp({super.key});
  @override
  State<signUp> createState()=> _SignUpState();
}
class _SignUpState extends State<signUp>
{
  final TextEditingController _controlleremail=TextEditingController();
  final TextEditingController _controllerpass=TextEditingController();
  final _formKey= GlobalKey<FormState>();
  String email='';
  String pass='';
  String msg='';
  bool loading=false;
  bool visible=true;
  void setVisible()
  {
    setState((){
      visible= !visible;
    });
  }
  void _handleLogin() async{
    setState((){loading=true;});
    setState((){msg='';});
    try{
    final res=await http.post(Uri.parse("http://10.0.2.2:8000/api/signup"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"email": email,"pass": pass})
    );
    setState((){
      msg=res.body;
      loading=false;
      email='';
      pass='';
    });
    
    }
    catch(err)
    {
      setState((){
        msg='Not able to sign up! Please try again later.';
        loading=false;
      });
      
    }
    setState((){email='';});
    setState((){pass='';});
    
  }
  @override
  void initState(){
    super.initState();
    setState((){
      pass='';
      email='';
    });
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 118, 13, 8),
        title:Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 10),
          child: Column(
            
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text('Notes',style: TextStyle(color: const Color.fromARGB(255, 234, 218, 218),fontFamily: 'spaced',fontSize: 30,fontWeight: FontWeight.bold)),
              Text('Your thoughts, organized.',style: TextStyle(color: const Color.fromARGB(255, 234, 218, 218),fontSize: 15))
            ]
          ),
        ),
        
      ),
      backgroundColor: Color.fromARGB(255, 234, 218, 218),
      body: 
            Padding(
              padding:EdgeInsets.all(20),
              child: Center(
      
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(0, 30, 0, 30),
                      child: Text('Hello there! Welcome to the Notes-App - Your new home for organized thougts. Sign up to start capturing your ideas, anytime, anywhere.',
                        style: TextStyle(
                          fontFamily: 'spaced',
                          color: Color.fromARGB(255, 118, 13, 8),
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,20,0,20),
                      child:Text('Email:',style: TextStyle(fontFamily: 'basic',fontSize: 17,color: Color.fromARGB(255, 118, 13, 8)))
                    ),
                    
                    TextFormField(
                      controller: _controlleremail,
                      onChanged: (value){
                        setState((){email=_controlleremail.text;});
                      },
                    
                      decoration:  InputDecoration(
                        hintText: 'Enter your email ',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 118, 13, 8).withAlpha(60),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ), 
                      ),
                      validator:(value){
                        if(value==null || value.isEmpty)
                        {
                          return 'Email is required';
                        }
                        if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value))
                        {
                          return 'Enter valid mail id';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Padding(  
                      padding: EdgeInsets.fromLTRB(0,20,0,20),  
                      child:Text('Password:',style: TextStyle(fontFamily: 'basic',fontSize: 17,color: Color.fromARGB(255, 118, 13, 8))),
                    ),
                    TextFormField(
                      controller: _controllerpass,
                      onChanged: (value){
                        setState((){pass=_controllerpass.text;});
                      },
                      obscureText: visible,
                      decoration:  InputDecoration(
                        hintText: 'Enter password ',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 118, 13, 8).withAlpha(60)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                         suffixIcon: IconButton(
                          onPressed: setVisible,
                          icon: Icon(visible? Icons.visibility : Icons.visibility_off  )
                        )
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty )
                        {
                          return "Password cannot be empty";
                        }
                        if(value.length<6 || !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$').hasMatch(value))
                        {
                          return 'Password must contain atleat one uppercase letter, one special character, one digit and should be longer than 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    
                    Padding(
                      padding: EdgeInsetsGeometry.all(50),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: loading? null :(){ 
                              setState((){
                                msg='';
                                email='';
                                pass='';
                              });
                              if(_formKey.currentState!.validate()){
                                 _handleLogin();
                              } 
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 118, 13, 8),
                              foregroundColor: Color.fromARGB(255, 234, 218, 62186),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              // shadowColor: Color.fromARGB(255, 118, 13, 8)
                            ),
                            child: Text('Sign up',style: TextStyle(fontSize: 20,fontFamily: 'basic')),
                            
                          ),
                        ),
                      ),
                    ),
                    if(msg.isNotEmpty)
                     Center(child:Text(msg,style: TextStyle(fontSize:15, color: Color.fromARGB(255, 118, 13, 8),))),
                    
                    // footer()
                    ]
                    ),
                ),
                ),
              
              ),
              // bottomNavigationBar: footer(),
              bottomNavigationBar: Row(mainAxisAlignment: MainAxisAlignment.center, children:[ Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20), child: Text('©️ 2025 This app is developed by Juhi Lasod'))]),
        );
  }
}