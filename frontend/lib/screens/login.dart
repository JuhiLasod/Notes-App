import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
// import './footer.dart';
import './signUp.dart';
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
  bool visible=true;
  bool isLoggedIn=false;
  bool loading=false;
  void setVisible()
  {
    
    setState((){
      visible= !visible;
    });
    
  }
  Future <void> saveEmail(String email,bool isLoggedIn)async
  {
    try{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email',email);
    await prefs.setBool('isLoggedIn',isLoggedIn);
    print("Saved email: ${prefs.getString('email')}");
    }
    catch(e){
      print("error is $e");
    }
  }
  
// void initState() {
//   super.initState();
//   saveEmail();
// }
  

  void _navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const signUp()));
  }

  void _handleLogin() async{
    setState((){
      loading=true;
      msg='';
    });
    
    final enteredEmail = _controlleremail.text.trim();
  final enteredPass = _controllerpass.text.trim();
    try{
    final res=await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"email": enteredEmail,"pass": enteredPass})
    );
    print("req sent to backend");
    if(res.body=='success')
    {
      print("inside succes block");
      setState(() {
        isLoggedIn=true;
      });
      await saveEmail(enteredEmail,isLoggedIn);
      print("after save mail");
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const home()));
    }
    else{
      setState((){msg=res.body;});
    }}
    catch(err)
    {
      setState((){msg='Not able to Login! Please try again later.';});
    }
    setState((){
      loading=false;
    });
    
  }
  @override
  void initState(){
    super.initState();
    setState((){ 
      pass='';
      email='';
    });
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
                    // onChanged: (value){
                    //   setState((){email=_controlleremail.text;});
                    // },
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
                    // onChanged: (value){
                    //   setState((){pass=_controllerpass.text;});R
                    // },
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
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0,20,0,0),
                    child: Center(
                      child: GestureDetector(
                        onTap: _navigateToSignUp,
                        child: Text('New here? Create your account now!',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline ,
                            color: Color.fromARGB(255, 118, 13, 8)
                          )
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(50),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: loading? null: _handleLogin,
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
