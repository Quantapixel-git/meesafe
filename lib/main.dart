import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mee Safe',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
