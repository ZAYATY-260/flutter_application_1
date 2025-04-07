import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/confirmLocation.dart';
import 'package:flutter_application_1/screens/thankyou.dart';
import 'package:image_picker/image_picker.dart';

class UploadReport extends StatefulWidget {
  const UploadReport({Key? key}) : super(key: key);

  @override
  State<UploadReport> createState() => _UploadReportState();
}

class _UploadReportState extends State<UploadReport> {
  File? _imageFile;
  final TextEditingController _locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
                            Text("Click to upload\na picture", textAlign: TextAlign.center, style: TextStyle(fontSize: 40),),
                            SizedBox(height: 8),
                            Text("OR", style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 4),
                            Text("Browse", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
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
