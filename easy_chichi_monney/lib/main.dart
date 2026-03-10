// File: main.dart
import 'package:easy_chichi_monney/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:easy_chichi_monney/screen/home/home_chart.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Pie Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // màn hình đầu tiên
      home: const HomePage(),  // <-- chỉnh lại
    );
  }
}
