import 'package:flutter/material.dart';
import './home.dart';
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
      setState((){msg='noit okay';});
    }
    
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: 
            Padding(
              padding:EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Text('email:'),
                  
                  TextField(
                    controller: _controlleremail,
                    onChanged: (value){
                      setState((){email=_controlleremail.text;});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email ',
                      border: OutlineInputBorder(), 
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text('password:'),
                  
                  TextField(
                    controller: _controllerpass,
                    onChanged: (value){
                      setState((){pass=_controllerpass.text;});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter password ',
                      border: OutlineInputBorder(), 
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        child: Text('Sign in'),
                      ),
                    ),
                  ),
                  Text(msg)
                  ]
                  ),
                )
              )
        );
  }
}
