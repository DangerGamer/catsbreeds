import 'package:flutter/material.dart';
import 'package:Catsbreeds/screens/splash_screen.dart';
import 'package:Catsbreeds/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashBeeds',
      routes: {
        'splashBeeds': (context) => const SplashScreen(),
        'homeScreen': (context) => HomeScreen(),
      },
      title: 'Cats Breeds',
    );
  }
}
