import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  _GameLibraryState createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  List<Map<String, dynamic>> images = [
    {'path': 'assets/images/jigsaw1.png'},
    {'path': 'assets/images/wordsearch.png'},
    {'path': 'assets/images/mam.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              color: Color.fromARGB(255, 254, 254, 255),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Library of Games',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4f22cd),
                    ),
                  )
                ],
              ),
            ),

            // Images Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: images.map((imageData) {
                  return GestureDetector(
                    onTap: () {
                      // Handle the click action for the image
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AspectRatio(
                              aspectRatio: 16 / 7,
                              child: Image.asset(
                                imageData['path'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 8,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Play', // Replace with your desired text
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white.withOpacity(1.0),
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
              // Handle the game library button click
            }),
            _buildNavigationButton(Icons.photo_album, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Album()),
              );
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

  // Helper method to build navigation buttons
  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: const Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }
}
