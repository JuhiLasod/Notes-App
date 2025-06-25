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
  List<Map<String, dynamic>> notes = [];
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

  void deleteNotes( String title,String content) async {
  try {
    final res = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': savedEmail, 'title': title , 'content': content}),
    );
    setState((){
      msg=res.body;
    });
    fetchNotes();
  }
  catch(e)
  {
    print("failed");
  }
  }
  void fetchNotes() async {
  try {
    final res = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/fetch-notes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': savedEmail}),
    );

    print("res.body: ${res.body}");
    final data = json.decode(res.body);

    if (data is List) {
      setState(() {
        notes = List<Map<String, dynamic>>.from(data);

        msg = '';
      });
    } else {
      setState(() {
        notes = [];
        msg = 'No notes found';
      });
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      msg = 'Failed to load notes';
    });
  }
}

  void _handleNew()async{
    try{
      await Navigator.push(context, MaterialPageRoute(builder: (context)=> const newNote()));
      fetchNotes();
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
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Text(msg),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _handleNew,
            child: Text('Add New'),
          ),
          if (msg.isNotEmpty) Text(msg),
          if (isLoading)
            CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(notes[index]['title']?.isNotEmpty == true? notes[index]['title']: 'No Title'),
                  subtitle: Text(notes[index]['content']?.isNotEmpty == true? notes[index]['content']: 'No content'),
                  trailing: ElevatedButton(
                    onPressed: (){deleteNotes(notes[index]['title'],notes[index]['content']);},
                    child: Text('delete'),
                  )
                ),
              ),
            ),
        ],
      ),
    ),
  );
}


}
