import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  String savedEmail = '';
  bool isLoading = true;

  void loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    setState(() {
      savedEmail = email ?? 'No email found';
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                savedEmail,
                style: const TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
