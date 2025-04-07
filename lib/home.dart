import 'package:flutter/material.dart';

void main() => runApp(ReportTrackerApp());

class ReportTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Card
              SizedBox(height: 130),
              Container(
                width: double.infinity,
                height: 340,
                padding: const EdgeInsets.all(20),
                
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 110,
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.08,
                        child: Icon(Icons.delete_outline, size: 210),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How you can\nTrack your  reports",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "With you we will help ecology",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Navigate to reports page or handle click
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("My Reports", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                Icon(Icons.article_outlined),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 110),

              // More Services Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "More services",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "see more",
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Service Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ServiceIcon(iconPath: "assets/streetlight.jpg"),
                  ServiceIcon(iconPath: "assets/garbage.png"),
                  ServiceIcon(iconPath: "assets/crack.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String iconPath;

  const ServiceIcon({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(iconPath, fit: BoxFit.contain),
    );
  }
}
