import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gunita20/screens/loading.dart';

import 'image_model.dart';

class ImagesScreen extends StatefulWidget {
  final User currentUser;

  const ImagesScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<ImageModel> images = [];
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    // Load existing images from Firebase or any other storage
    // You can fetch image URLs from Firestore or any other database
    // and update the _imageUrls list
    // For example:
    // _imageUrls = await fetchImageUrls();

    // For demonstration purposes, let's initialize with some dummy data
    _imageUrls = [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      // Add more image URLs as needed
    ];

    setState(() {
      // Convert image URLs to ImageModel objects
      images = _imageUrls
          .map((imageUrl) => ImageModel(id: images.length.toString(), imageUrl: imageUrl, textInfo: ""))
          .toList();
    });
  }

  Future<void> _uploadImageToFirebase() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${widget.currentUser.uid}/albums/${pickedFile.path.split('/').last}');
      final uploadTask = ref.putFile(
        File(pickedFile.path),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      await uploadTask.whenComplete(() async {
        showDialog(
          context: context,
          builder: (context) {
            return Loading();
          },
        );

        String downloadUrl = await ref.getDownloadURL();

        setState(() {
          images.add(ImageModel(id: images.length.toString(), imageUrl: downloadUrl, textInfo: ""));
        });

        // Save the new image URL to Firestore or any other database
        // For example:
        // await saveImageUrlToDatabase(downloadUrl);

        // For now, we'll just update the local _imageUrls list
        _imageUrls.add(downloadUrl);

        // Dismiss the loading dialog
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Album'),
        backgroundColor: Color(0xff4f22cd),
      ),
      body: Stack(
        children: [
          _buildImageGrid(context),
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _uploadImageToFirebase,
              style: ElevatedButton.styleFrom(
                primary: Color(0xff4f22cd),
              ),
              child: Text('Add Photo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageWithTextScreen(image: image),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageWithTextScreen extends StatelessWidget {
  final ImageModel image;

  const ImageWithTextScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Album'),
        backgroundColor: Color(0xff4f22cd),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoView(imageProvider: NetworkImage(image.imageUrl)),
                  ),
                );
              },
              child: Image.network(image.imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
