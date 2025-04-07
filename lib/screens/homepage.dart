import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profilepage.dart';
import 'package:flutter_application_1/screens/reports.dart';
import 'package:flutter_application_1/screens/uploadReport.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (index == 1)
          {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ReportsPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main Card
                        Container(
                          width: double.infinity,
                          height: 320,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[50],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
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
                                    "How you can\nTrack your reports",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "With you we will help ecology",
                                    style: TextStyle(fontSize: 14, color: Colors.black54),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle "My Reports" tap
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

                        const SizedBox(height: 120),

                        // More Services Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "More services",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "see more",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Services Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                          ServiceIcon(
                            iconPath: "assets/streetlight.jpg",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => UploadReport()),
                              );
                            },
                          ),
                          ServiceIcon(
                            iconPath: "assets/garbage.png",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => UploadReport()),
                              );
                            },
                          ),
                          ServiceIcon(
                            iconPath: "assets/crack.png",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => UploadReport()),
                              );
                            },
                          ),
                        ],
                                              ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const ServiceIcon({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
      onTap: onTap,
    // ignore: unused_label
    child:  Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Image.asset(iconPath, fit: BoxFit.contain),
    ),
    );
  }
}
