import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './newNote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  String savedEmail = '';
  bool isLoading = true;
  String msg='';
  String note='';
  final TextEditingController _noteController= TextEditingController();
  void loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    setState(() {
      savedEmail = email ?? 'No email found';
      isLoading = false;
    });
  }

  void _handleNew()async{
    // try{
    //   final res=await http.post(Uri.parse('http://10.0.2.2:8000.api/new'),
    //     headers:{'Content-Type': 'application/json'},
    //     body: jsonEncode({
    //       'email':savedEmail,
    //       'note': note})
    //   );
    //   if(res=='success')
    //   {
    //     setState((){
    //       msg='added new';
    //     });
    //   }
    //   else{
    //     setState((){
    //       msg='not able to add new';
    //     });
    //   }
    
    // }
    // catch(e){
    //   print(e);
    // }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const newNote()));
  }
  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(50),
        child: Column(
          children: [Center(
            child: ElevatedButton(
              onPressed: _handleNew,
              child: Text('add new')
            )
                  
          ),
          Text(msg)
          ]
        ),
      ),
    );
  }
}
