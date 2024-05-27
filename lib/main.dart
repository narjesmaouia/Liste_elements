import 'package:flutter/material.dart';
import 'package:liste_elements/screens/AffichageElement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application des Elements',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AffichageElement(),
    );
  }
}