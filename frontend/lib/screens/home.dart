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
  List <String> notes= [];
  final TextEditingController _noteController= TextEditingController();
  void loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    // setState(() {
    //   savedEmail = email ?? 'No email found';
    //   isLoading = false;
    // });
    setState(() {
    savedEmail = email ?? 'No email found';
    isLoading = false;
  });

  if (email != null) {
    fetchNotes(); 
  }
  }

  void fetchNotes()async{
    try{
      final res=await http.post(Uri.parse('http://10.0.2.2:8000/api/fetch-notes'),
        headers:{'Content-Type': 'application/json'},
        body: jsonEncode({
          'email':savedEmail,
          })
      );
      print("req sent to backend");
      if(res.statusCode==200)
      {
        setState((){
          msg=res.body;
        });
        // final List <String> data=json.decode(res.body);
        // setState((){
        //   notes=List<String>.from (data);
        // });
      }
      else
      {
        setState((){
          msg=res.body;
        });
      }
    
    }
    catch(e){
      print(e);
    }
    
  }
  void _handleNew()async{
    try{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const newNote()));
      
    }
    catch(e)
    {
      setState((){
          msg='not ble to add new';
        });
    }
  }
  @override
  void initState() {
    super.initState();
    loadEmail();
    // fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    fetchNotes();
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
