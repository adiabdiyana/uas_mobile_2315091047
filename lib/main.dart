import 'package:flutter/material.dart';
import 'package:uas_mobile_2315091047/screens/login_screen.dart';
// ignore: duplicate_import
import 'screens/login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Sorting Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Halaman pertama yang dibuka
    );
  }
}