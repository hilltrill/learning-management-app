import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  static const routeName = "classes-screen";
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Classes"),
      ),
    );
  }
}
