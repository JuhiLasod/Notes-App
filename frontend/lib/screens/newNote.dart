import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class newNote extends StatefulWidget {
  const newNote({super.key});

  @override
  State<newNote> createState() => _newNoteState();
}

class _newNoteState extends State<newNote> {
  String savedEmail = '';
  bool isLoading = true;
  String msg='';
  String content='';
  String title='';
  final TextEditingController _noteController= TextEditingController();
  final TextEditingController _titleController= TextEditingController();
  // final TextEditingController _titleController= TextEditingController();
  void loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    setState(() {
      savedEmail = email ?? 'No email found';
      isLoading = false;
    });
  }

  void _handleNew()async{
    try{
      content= _noteController.text;
      title= _titleController.text;
      final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/new'),
        headers:{'Content-Type': 'application/json'},
        body: jsonEncode({
          'email':savedEmail,
          'title': title,
          'content': content})
      );
      print(res.body);
      if(res.body=='success')
      {
        setState((){
          msg='added new';
        });
      }
      else{
        setState((){
          msg='not able to add new';
        });
      }
    
    }
    catch(e){
      print(e);
    }
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
        padding: EdgeInsetsGeometry.all(50.0),
        child: Column(
          children: [
            Text(msg),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'title',
                hintStyle: TextStyle(color: Color.fromARGB(255, 118, 13, 8).withAlpha(60),)
              )
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Text',
                hintStyle: TextStyle(color: Color.fromARGB(255, 118, 13, 8).withAlpha(60),)
              )

            ),
            Padding(
                    padding: EdgeInsetsGeometry.all(50),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleNew,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 118, 13, 8),
                            foregroundColor: Color.fromARGB(255, 234, 218, 62186),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            // shadowColor: Color.fromARGB(255, 118, 13, 8)
                          ),
                          child: Text('Add',style: TextStyle(fontSize: 20,fontFamily: 'basic')),
                          
                        ),
                      ),
                    ),
                  ),
                  Center(child:Text(msg,style: TextStyle(fontSize:15, color: Color.fromARGB(255, 118, 13, 8),))),
                  
                  // footer()
                  ]
                  ),
                ),
              
              );
    
  }
}
