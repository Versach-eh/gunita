import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/add_album_screen.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  List<MyAlbum> albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  void _loadAlbums() {
    // Simulate loading data for demonstration purposes
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Mock data
        albums = [
          MyAlbum(id: '1', title: 'Album 1', imageUrls: []),
          MyAlbum(id: '2', title: 'Album 2', imageUrls: []),
          MyAlbum(id: '3', title: 'Album 3', imageUrls: []),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 202, 202),  // Set the background color here
        body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Your Memories",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAlbumScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 119, 119, 119).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Adjust padding as needed
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center, // Adjust the alignment of the text
                      children: [
                        SizedBox(width: 14),
                        Text(
                          'Create an album',
                          style: TextStyle(
                            fontSize: 24, // Adjust font size as needed
                            fontFamily: 'Magdelin',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(30), // Adjust padding as needed for the circle size
                child: Icon(
                  Icons.photo,
                  size: 30, // Adjust the size of the icon
                  color: Colors.black,
                ),
              ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Test123",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Birthday:",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Age:",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Album()),
              // );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30.0,
        color: const Color.fromARGB(255, 133, 133, 133),
      ),
      onPressed: onPressed,
    );
  }

  void _onTabTapped(int index) {
    // Existing code...
  }
}
  
  
