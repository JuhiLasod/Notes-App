import 'package:flutter/material.dart';
import './home.dart';
// import './footer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class login extends StatefulWidget{
  const login({super.key});
  @override
  State<login> createState()=> _LoginState();
}

class _LoginState extends State<login>
{
  final TextEditingController _controlleremail=TextEditingController();
  final TextEditingController _controllerpass=TextEditingController();
  String email='';
  String pass='';
  String msg='';
  void _handleLogin() async{
    try{
    final res=await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"email": email,"pass": pass})
    );

    if(res.body=='success')
    {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>const home()));
    }
    else{
      setState((){msg=res.body;});
    }}
    catch(err)
    {
      setState((){msg='Not able to Login! Please try again later.';});
    }
    
  }
  @override
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
      
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,20,0,20),
                    child:Text('Email:',style: TextStyle(fontFamily: 'basic',fontSize: 17,color: Color.fromARGB(255, 118, 13, 8)))
                  ),
                  
                  TextField(
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
                  ),
                  const SizedBox(height: 10.0),
                  Padding(  
                    padding: EdgeInsets.fromLTRB(0,20,0,20),  
                    child:Text('Password:',style: TextStyle(fontFamily: 'basic',fontSize: 17,color: Color.fromARGB(255, 118, 13, 8))),
                  ),
                  TextField(
                    controller: _controllerpass,
                    onChanged: (value){
                      setState((){pass=_controllerpass.text;});
                    },
                    decoration:  InputDecoration(
                      hintText: 'Enter password ',
                      hintStyle: TextStyle(color: Color.fromARGB(255, 118, 13, 8).withAlpha(60)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                       
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  
                  Padding(
                    padding: EdgeInsetsGeometry.all(50),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 118, 13, 8),
                            foregroundColor: Color.fromARGB(255, 234, 218, 62186),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            // shadowColor: Color.fromARGB(255, 118, 13, 8)
                          ),
                          child: Text('Sign in',style: TextStyle(fontSize: 20,fontFamily: 'basic')),
                          
                        ),
                      ),
                    ),
                  ),
                  Center(child:Text(msg,style: TextStyle(fontSize:15, color: Color.fromARGB(255, 118, 13, 8),))),
                  
                  // footer()
                  ]
                  ),
                ),
              
              ),
              // bottomNavigationBar: footer(),
              bottomNavigationBar: Row(mainAxisAlignment: MainAxisAlignment.center, children:[ Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20), child: Text('©️ 2025 This app is developed by Juhi Lasod'))]),
        );
  }
}
