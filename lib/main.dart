import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   

  // Just initialize without options on Android (since google-services.json is used)
  await Firebase.initializeApp(); 

  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
