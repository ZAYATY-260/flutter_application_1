import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/confirmLocation.dart';
import 'package:flutter_application_1/screens/thankyou.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart'; // Import for web
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';  // Add this line

class UploadReport extends StatefulWidget {
  const UploadReport({Key? key}) : super(key: key);

  @override
  State<UploadReport> createState() => _UploadReportState();
}

class _UploadReportState extends State<UploadReport> {
  dynamic _imageFile; // This can be either File or Uint8List
  final TextEditingController _locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Roboflow API URL and API Key
  final String _apiUrl = 'https://detect.roboflow.com';
  final String _apiKey = 'wBWQCEsJDkSyCXINXUyo';
  final String _modelId = 'accident-classification-jbmo5/7'; // Your model ID

  // Pick an image
  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Web-specific image picker
      final result = await ImagePickerWeb.getImageAsBytes();
      if (result != null) {
        setState(() {
          _imageFile = result;  // Store the image bytes for web
        });
        _detectAccident(result);
      }
    } else {
      // Mobile-specific image picker
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                      });
                      _detectAccident(_imageFile!);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                      });
                      _detectAccident(_imageFile!);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

// Call the Roboflow API for detection
Future<void> _detectAccident(dynamic imageFile) async {
  final uri = Uri.parse("$_apiUrl/$_modelId?api_key=$_apiKey");

  final request = http.MultipartRequest('POST', uri);

  // Web-specific handling for image
  if (kIsWeb) {
    final multipartFile = http.MultipartFile.fromBytes('image', imageFile, filename: 'accident.jpg');
    request.files.add(multipartFile);
  } else {
    // Mobile-specific handling for image
    final bytes = await imageFile.readAsBytes();
    final multipartFile = http.MultipartFile.fromBytes('image', bytes, filename: 'accident.jpg');
    request.files.add(multipartFile);
  }

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
  // Print the raw results to the console for debugging
  print('Raw Detection Results: $results');

  // Loop through the predictions and print each one to the console
  for (var prediction in results['predictions']) {
    print("Prediction: ${prediction['class']} detected with confidence ${prediction['confidence']}");
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Detection Results"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Predictions:"),
              // Loop through each prediction and display it
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
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

  Widget _buildCategoryButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select Categories:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton("Trash"),
                  _buildCategoryButton("Debris"),
                  _buildCategoryButton("Hazard"),
                ],
              ),
              const SizedBox(height: 100),

              // Upload Box
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: _imageFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.cloud_upload_outlined, size: 40),
                            SizedBox(height: 8),
                            Text("Click to upload\na picture", textAlign: TextAlign.center, style: TextStyle(fontSize: 40)),
                            SizedBox(height: 8),
                            Text("OR", style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 4),
                            Text("Browse", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _imageFile is File
                              ? Image.file(_imageFile, fit: BoxFit.cover)
                              : Image.memory(_imageFile, fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 70),

              // Location Field
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "Enter your location...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmLocationScreen()),
                  );
                },
                child: const Text(
                  "Detect Location",
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ),

              const Spacer(), 

              // Send Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ThankYouScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
