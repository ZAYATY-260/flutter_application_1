import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AccidentDetectionPage extends StatefulWidget {
  @override
  _AccidentDetectionPageState createState() => _AccidentDetectionPageState();
}

class _AccidentDetectionPageState extends State<AccidentDetectionPage> {
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  // Roboflow API URL and API Key
  final String _apiUrl = 'https://detect.roboflow.com';
  final String _apiKey = 'wBWQCEsJDkSyCXINXUyo';
  final String _modelId = 'accident-classification-jbmo5/7'; // Your model ID

  // Pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
      _detectAccident(pickedFile);
    }
  }

  // Call the Roboflow API for detection
  Future<void> _detectAccident(XFile image) async {
    final uri = Uri.parse("$_apiUrl/$_modelId?api_key=$_apiKey");

    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(respStr);

      // Handle the prediction results
      _showDetectionResults(decodedResponse);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Show the detection results
  void _showDetectionResults(Map<String, dynamic> results) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detection Results"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Predictions:"),
                // Iterate through the results and display them
                for (var prediction in results['predictions'])
                  Text("${prediction['class']} detected with confidence ${prediction['confidence']}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accident Detection"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageUrl == null
                ? Text("No image selected.")
                : Image.file(File(_imageUrl!)),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image for Detection"),
            ),
          ],
        ),
      ),
    );
  }
}
