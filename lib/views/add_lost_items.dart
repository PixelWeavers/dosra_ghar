import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? imageUrl;
  final ImagePicker _imagePicker = ImagePicker();
  bool isloading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  pickImage() async {
    XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (res != null) {
      uploadtoFirebase(File(res.path));
    }
  }

  uploadtoFirebase(image) async {
    setState(() {
      isloading = true;
    });
    try {
      Reference sr = FirebaseStorage.instance
          .ref()
          .child('Images/${DateTime.now().millisecondsSinceEpoch}.png');

      await sr.putFile(image);

      imageUrl = await sr.getDownloadURL();
    } catch (e) {
      print('Error occurred $e');
    }
    setState(() {
      isloading = false;
    });
  }

  uploadDataToFirebase() async {
    try {
      if (_titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          imageUrl != null) {
        // Upload data to Firestore
        await FirebaseFirestore.instance.collection('uploads').add({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'imageUrl': imageUrl,
        });

        print('Data uploaded successfully');

        // Clear text fields after submission
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          imageUrl = null;
        });

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data uploaded successfully'),
          ),
        );
      } else {
        // Show error message if any field is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      }
    } catch (e) {
      print('Error occurred $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            imageUrl == null
                ? Icon(
                    Icons.person,
                    size: 200,
                    color: Colors.grey,
                  )
                : Center(
                    child: Image.network(
                      imageUrl!,
                      height: 50,
                    ),
                  ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(Icons.image),
                label: Text(
                  'Pick Image',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _titleController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isloading) SpinKitThreeBounce(color: Colors.white, size: 20),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(120,8,120,8),
              child: ElevatedButton(
                onPressed: () {
                  uploadDataToFirebase();
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
