import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homepage.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  void initState() {
    super.initState();

    // Timer for 3 seconds before navigating
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      ); // or use pushReplacement to go to a specific screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Icon
            Positioned(
              top: 200,
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.recycling, size: 300, color: Colors.white),
              ),
            ),

            // Centered Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, size: 40, color: Colors.black),
                ),
                SizedBox(height: 24),
                Text(
                  "Thank you",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "For keeping Egypt Clean",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
