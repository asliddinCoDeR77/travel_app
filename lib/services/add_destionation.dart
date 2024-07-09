import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class AddEditDestinationScreen extends StatefulWidget {
  final String? id;
  final String? title;
  final String? photoUrl;
  final String? location;

  const AddEditDestinationScreen(
      {super.key, this.id, this.title, this.photoUrl, this.location});

  @override
  _AddEditDestinationScreenState createState() =>
      _AddEditDestinationScreenState();
}

class _AddEditDestinationScreenState extends State<AddEditDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _photoUrl;
  String? _location;

  final ImagePicker _picker = ImagePicker();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _title = widget.title;
      _photoUrl = widget.photoUrl;
      _location = widget.location;
    }
  }

  Future<void> _pickImage() async {
    try {
      if (await Permission.camera.request().isGranted) {
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          final File file = File(pickedFile.path);
          final Reference storageRef = FirebaseStorage.instance
              .ref('destinations/${DateTime.now().toIso8601String()}');
          final UploadTask uploadTask = storageRef.putFile(file);
          final TaskSnapshot snapshot = await uploadTask;
          final String url = await snapshot.ref.getDownloadURL();
          setState(() {
            _photoUrl = url;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No image was selected'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Camera permission is required to take photos'),
        ));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred while picking the image'),
      ));
    }
  }

  Future<void> _getLocation() async {
    try {
      if (await Permission.location.request().isGranted) {
        final location = Location();
        final currentLocation = await location.getLocation();
        setState(() {
          _location =
              'Lat: ${currentLocation.latitude}, Lng: ${currentLocation.longitude}';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permission is required to get location'),
        ));
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred while getting location'),
      ));
    }
  }

  Future<void> _saveDestination() async {
    if (_formKey.currentState!.validate() &&
        _photoUrl != null &&
        _location != null) {
      setState(() {
        _loading = true;
      });
      final data = {
        'title': _title,
        'photoUrl': _photoUrl,
        'location': _location,
      };
      if (widget.id == null) {
        await FirebaseFirestore.instance.collection('destinations').add(data);
      } else {
        await FirebaseFirestore.instance
            .collection('destinations')
            .doc(widget.id)
            .update(data);
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please complete all fields'),
      ));
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Add Destination' : 'Edit Destination'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _photoUrl == null
                        ? ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Pick Image'),
                          )
                        : Image.network(_photoUrl!),
                    const SizedBox(height: 16),
                    _location == null
                        ? ElevatedButton(
                            onPressed: _getLocation,
                            child: const Text('Get Location'),
                          )
                        : Text(_location!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveDestination,
                      child: Text(widget.id == null ? 'Add' : 'Save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
