import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/crossword.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/jigzaw.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  _GameLibraryState createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF2F6FC), Color(0xffDBE9F7).withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Library of Games',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4f22cd),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildClickableImage(
                      'assets/images/crossword.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CrosswordApp()),
                        );
                      },
                    ),
                    _buildClickableImage(
                      'assets/images/jigsaw.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PuzzleWidget()),
                        );
                      },
                    ),
                    _buildClickableImage(
                      'assets/images/mam.png',
                      () {
                        // Replace GameLibrary() with the appropriate screen.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => GameLibrary()),
                        // );
                      },
                    ),
                    _buildClickableImage(
                      'assets/images/majong.png',
                      () {
                        // Replace GameLibrary() with the appropriate screen.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => GameLibrary()),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1.0),
                borderRadius: BorderRadius.circular(10),
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
                    // Replace GameLibrary() with the appropriate screen.
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => GameLibrary()),
                    // );
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
          ],
        ),
      ),
    );
  }

  void _handleMouseEnter(int index) {
    setState(() {
      _hoveredIndex = index;
    });
  }

  void _handleMouseExit() {
    setState(() {
      _hoveredIndex = -1;
    });
  }

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

  Widget _buildClickableImage(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
