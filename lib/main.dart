import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCej8pMs2DF98PGmy__TJUI7NkTAiNAN0c",
      appId: "1:585980402153:android:1d5869be5f6ce9702cd378",
      messagingSenderId: "585980402153",
      projectId: "shaware3na-254f9",
      storageBucket: "shaware3na-254f9.appspot.com",
    ),
  );
 await dotenv.load(); // Load environment variables before running the app
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
