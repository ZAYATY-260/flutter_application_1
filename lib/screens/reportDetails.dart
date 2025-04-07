import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/reports.dart';


class ReportDetailsPage extends StatelessWidget {
  final Report report;

  const ReportDetailsPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(report.description),
            SizedBox(height: 16),
            Text('Status: ${report.status}', style: TextStyle(color: Colors.blueGrey)),
            SizedBox(height: 24),
            Text('Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: report.images.length,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/streetlight.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}