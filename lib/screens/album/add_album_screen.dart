// add_album_screen.dart
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/services/firebase_service.dart';

class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({super.key});

  @override
  _AddAlbumScreenState createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final TextEditingController _titleController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();


// CREATES THE ALBUM IN FIREBASE HERE. ,AYBE IMPLEMENT USER ACCOUNT ORGANIZING HERE
  void _submitForm() {
    final String title = _titleController.text.trim();
    if (title.isNotEmpty) {
      final MyAlbum newAlbum = MyAlbum(
        id: '',
        title: title,
        imageUrls: [],
        );

      firebaseService.addAlbum(newAlbum);         // CREATES the NEW album in that specific firestore collection
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Album'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Album'),
            ),
          ],
        ),
      ),
    );
  }
}
