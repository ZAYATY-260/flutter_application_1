import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profilepage.dart';
import 'package:flutter_application_1/screens/reports.dart';
import 'package:flutter_application_1/screens/uploadReport.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> allPosts = [
    {"image": "assets/reports/car accident.jpg", "caption": "Streetlight broken on Main St", "time": "2 hours ago", "location": "Main St, City"},
    {"image": "assets/reports/earthquake.jpg", "caption": "Overflowing trash can on 5th Ave", "time": "4 hours ago", "location": "5th Ave, City"},
    {"image": "assets/reports/Fire.jpg", "caption": "Crack in sidewalk on Broadway St", "time": "6 hours ago", "location": "Broadway St, City"},
  ];

  List<Map<String, String>> displayedPosts = [];
  int postLimit = 3;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      displayedPosts = allPosts.take(postLimit).toList();
    });
  }

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
          } else if (index == 1) {
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
                                    onTap: () {},
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

                        const SizedBox(height: 20),

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

                        // Services Icons (Now with spacing between them)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                              SizedBox(width: 16),
                              ServiceIcon(
                                iconPath: "assets/garbage.png",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => UploadReport()),
                                  );
                                },
                              ),
                              SizedBox(width: 16),
                              ServiceIcon(
                                iconPath: "assets/crack.png",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => UploadReport()),
                                  );
                                },
                              ),
                              SizedBox(width: 16),
                              ServiceIcon(
                                iconPath: "assets/anotherIcon.png",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => UploadReport()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Instagram-like Reports under each Service
                        _buildInstagramPostSection(),

                        // Load more button if posts are available to load
                        if (postLimit < allPosts.length)
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Load More",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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

  Widget _buildInstagramPostSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Reports",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        Column(
          children: displayedPosts.map((post) {
            return InstagramPost(
              imagePath: post["image"]!,
              caption: post["caption"]!,
              time: post["time"]!,
              location: post["location"]!,
            );
          }).toList(),
        ),
      ],
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
      child: Container(
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

class InstagramPost extends StatelessWidget {
  final String imagePath;
  final String caption;
  final String time;
  final String location;

  const InstagramPost({super.key, required this.imagePath, required this.caption, required this.time, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.black, // Set card background color to black
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Image.asset(
            imagePath,
            fit: BoxFit.cover, // Ensures the image covers the space responsively
            width: double.infinity, // Ensures the image takes full width
            height: 250, // Increased height of the card
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(caption, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                Text("Time: $time", style: TextStyle(color: Colors.white54, fontSize: 12)),
                SizedBox(width: 20),
                Text("Location: $location", style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
