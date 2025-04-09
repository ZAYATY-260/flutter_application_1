import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ProfilePage.dart';
import 'package:flutter_application_1/screens/homepage.dart';
import 'package:flutter_application_1/screens/reportDetails.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reports Page',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ReportsPage(),
    );
  }
}

class Report {
  final String title;
  final String description;
  final String status;
  final List<String> images;

  Report({required this.title, required this.description, required this.status, required this.images});
}

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Report> reports = [
    Report(
      title: 'Overflowing bin',
      description: 'Bin is overflowing in sector 5 near the mall.',
      status: 'Pending',
      images: ['https://via.placeholder.com/150'],
    ),
    Report(
      title: 'Broken street light',
      description: 'Street light not working on main road.',
      status: 'Resolved',
      images: ['https://via.placeholder.com/150'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reports'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if(index == 2)
          {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Dismissible(
            key: Key(report.title + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() => reports.removeAt(index));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${report.title} deleted')));
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccidentDetectionPage(),
                  ),
                );
              },
              
              child: SizedBox(
                 width: 390,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(report.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Status: ${report.status}', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              
            ),
          );
        },
      ),
    );
  }
}