// album_images_screen.dart
// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import 'image_model.dart';


class AlbumImagesScreen extends StatefulWidget {
  final User currentUser;
  final MyAlbum album;

  const AlbumImagesScreen({super.key, required this.currentUser, required this.album});

  @override
  _AlbumImagesScreenState createState() => _AlbumImagesScreenState();
}

class _AlbumImagesScreenState extends State<AlbumImagesScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<ImageModel> images = [];
  List<String> _imageUrls = [];


  @override
  void initState() {
    super.initState();
    _imageUrls = widget.album.imageUrls;
  }



  Future<void> _uploadImageToFirebase() async {

    final user = FirebaseAuth.instance.currentUser!;
    // final MyAlbum album;

    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
       
      // Uploading image to Firebase Storage
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${widget.currentUser.uid}/albums/${widget.album.id}/${pickedFile.path.split('/').last}');
      final uploadTask = ref.putFile(
        File(pickedFile.path),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      await uploadTask.whenComplete(() async {

        // Getting the image URL after upload completion
        String downloadUrl = await ref.getDownloadURL();

        setState(() {
          
          images.add(ImageModel(id: images.length.toString(), imageUrl: downloadUrl, textInfo: ""));
        });

        widget.album.imageUrls.add(downloadUrl);
        
    // use this everytime you want to do something will images in Firestore
    CollectionReference _firestoreReference = FirebaseFirestore.instance.collection('Users/${user.uid}/albums');

    late Stream<QuerySnapshot> _stream;
    _stream = _firestoreReference.snapshots();


   _firestoreReference.doc(widget.album.id).update({
        'imageUrls': FieldValue.arrayUnion([downloadUrl]),
      });
  

      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.title),
        backgroundColor: Color(0xff4f22cd),
      ),


      // Display the list
      // body: ListView.builder(
      //   itemCount: images.length,
      //   itemBuilder: (context, index) {
          
      //     final image = images[index];
      //     return ListTile(
      //       onTap: () {
      //         // Open image with photoview
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => ImageWithTextScreen(image: image),
      //           ),
      //         );
      //       },
      //       title: Text(image.textInfo),
      //       leading: Image.network(image.imageUrl),
      //       subtitle: Text(image.textInfo),
      //     );
      //   },
      // ),

      body: _buildImageGrid(context),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4f22cd),
        onPressed: _uploadImageToFirebase,
        child: Icon(Icons.add),
      ),
    );
  } // end of widget build

// start of pasted
  Widget _buildImageGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // crossAxisSpacing: 8.0,
        // mainAxisSpacing: 8.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];

        return GestureDetector(
          onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageWithTextScreen(image: image),
                ),
              );},
          child: Container(
            decoration:BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image.imageUrl),
                fit:BoxFit.cover,)
                ,)
                ,)
        );
      },
    );
  }

  void _viewImage(BuildContext context, String imageUrl, int index) {
    TextEditingController _textEditingController = TextEditingController(text: ''); // Initialize with existing text (if any)

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('View Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                ),
              ),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Enter text'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newText = _textEditingController.text;
                // Update the Firestore document with the new text (if needed)
                await _updateImageText(newText, index);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateImageText(String newText, int index) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return;
    }

    final userId = currentUser.uid;
    final albumRef = _firestore.collection('Users').doc(userId).collection('Albums').doc('albumId'); // Replace 'albumId' with the actual album ID

    final albumData = (await albumRef.get()).data();
    if (albumData == null || albumData['imageUrls'] == null) {
      return;
    }

    List<String> imageUrls = List.from(albumData['imageUrls']);
    if (index >= 0 && index < imageUrls.length) {
      imageUrls[index] = newText;
      await albumRef.update({'imageUrls': imageUrls});
    }
  }

  // end of pasted

  
}

class ImageWithTextScreen extends StatefulWidget {
  final ImageModel image;

  const ImageWithTextScreen({super.key, required this.image});

  @override
  _ImageWithTextScreenState createState() => _ImageWithTextScreenState();
}

class _ImageWithTextScreenState extends State<ImageWithTextScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${widget.image.textInfo}'),
        backgroundColor: Color(0xff4f22cd),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Open image with photoview
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoView(imageProvider: NetworkImage(widget.image.imageUrl)),
                  ),
                );
              },
              child: Image.network(widget.image.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,

              decoration: InputDecoration(
                labelText: 'Edit the title for this image',
                labelStyle:TextStyle(fontSize:23),
                border: OutlineInputBorder(),
              
              ),
              onChanged: (value) {
                setState(() {
                  widget.image.textInfo = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}