import 'package:flutter/material.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const SoftwarePersonaECommerceApp());
}

class SoftwarePersonaECommerceApp extends StatelessWidget {
  const SoftwarePersonaECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Software Persona E-Commerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
