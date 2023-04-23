import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  File? _image;
  String? _name;
  int? _age;
  String promptName = "What is your name?";
  String promptAge = "What is your age?";
  String promptFile = "Tap Icon to upload your image file";

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _submitProfile() {
    setState(() {
      _name = _nameController.text;
      _age = int.tryParse(_ageController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // you need to fill up this with something appropriate
      // ),
      // body:
      // you need to fill up this that builds the widget tree body for the profile page
      //
      //
      appBar: AppBar(
        title: const Text("Simple Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 700,
              width: 300,
              padding: const EdgeInsets.all(3),
              child: Column(
                children: <Widget>[
                  Text(
                    promptName,
                    style: const TextStyle(fontSize: 24),
                  ),
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    promptAge,
                    style: const TextStyle(fontSize: 24),
                  ),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    promptFile,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Choose Image'),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 40.0,
                      child: CircleAvatar(
                        radius: 38.0,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (_image != null)
                              ? Image.file(_image!)
                              : Image.asset('assets/images/default.jpeg'),
                        ),
                      ),
                    ),
                  ),
                  Text("Name : $_name"),
                  Text("Age : $_age"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitProfile();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
