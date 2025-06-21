import 'package:flutter/material.dart';

class home extends StatefulWidget{
  const home({super.key});
  @override
  State<home> createState()=> _HomeState();
}

class _HomeState extends State<home>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(child: Text('this is home page'))
    );
  }
}