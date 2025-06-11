import 'package:flutter/material.dart';
import 'package:palcomgas/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palcommerce',
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

