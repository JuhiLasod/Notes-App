import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget{
  const MyApp({Key? key}): super(key:key);
  
  @override
  State <MyApp> createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp>{
  final TextEditingController _controller=TextEditingController();
  String email='';
  String pass='';

  @override
  
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
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
                    controller: _controller,
                    onChanged: (value){
                      setState((){email=_controller.text;});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email ',
                      border: OutlineInputBorder(), 
                    ),
                  ),
                  const SizedBox(height: 20.0,width: 40.0),
                  Text('password:'),
                  
                  TextField(
                    controller: _controller,
                    onChanged: (value){
                      setState((){pass=_controller.text;});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter password ',
                      border: OutlineInputBorder(), 
                    ),
                  ),
                  const SizedBox(height: 20.0,width: 40.0),
                  
                  Center(
                    child: FloatingActionButton(
                      onPressed: (){},
                      child: Text('Sign in')
                    ),
                  )
                  ]
                  ),
                )
              )
        )
      
    );
  }
}