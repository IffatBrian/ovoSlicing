import 'package:flutter/material.dart';
void main() {
  runApp(const OvoApp());
}

class OvoApp extends StatelessWidget {
  const OvoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: OvoApp());
  }
}