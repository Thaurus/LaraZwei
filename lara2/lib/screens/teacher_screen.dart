import 'package:flutter/material.dart';
import 'package:lara2/setup/api.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lehrer Ansicht'),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton(onPressed: (){
              uploadString("Testtest");
            }, child: Text("Test"))
          ],
        )
        
        )
      ),
    );
  }
}