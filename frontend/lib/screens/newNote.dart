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

            ),
            TextField(
              controller: _noteController,

            ),
            ElevatedButton(
              onPressed: _handleNew, 
              child: Text('add')
            )
          ],
        )
      ),
    );
  }
}
