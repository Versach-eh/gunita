// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isContainerVisible = true;
  
  // _stream = _userInformationReference.snapshots();
  final user = FirebaseAuth.instance.currentUser!;
  // CollectionReference _userInformationReference = FirebaseFirestore.instance.collection('Users/${user.uid}/UserDetails');
  // late Stream<QuerySnapshot> _stream;

  final List<IconData> containerIcons = [
    Icons.emoji_emotions,
    Icons.emoji_emotions,
    Icons.emoji_emotions,
    Icons.emoji_emotions,
    Icons.emoji_emotions,
  ];

  // final user = FirebaseAuth.instance.currentUser!;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7f9f9),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40, // Adjust the desired height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: Color(0xff8a8a8a),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.black), // Adjust text color
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Hi, ${user.email}!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff3b0d6b),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 320, // Adjust the desired width
            height: 85, // Adjust the desired height
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xff4f22cd),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Junjuns birthday',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 0),
                    Text(
                      'June 00, 2023',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          AnimatedOpacity(
            opacity: isContainerVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3b0d6b),
                    ),
                  ),
                ),
                SizedBox(height: 0),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xff4f22cd),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle container tap
                              setState(() {
                                isContainerVisible = false;
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Icon(
                                containerIcons[i],
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          AnimatedOpacity(
            opacity: isContainerVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 3; i < 5; i++)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xff4f22cd),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle container tap
                              setState(() {
                                isContainerVisible = false;
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Icon(
                                containerIcons[i],
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Your Recent Activities',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3b0d6b),
                  ),
                ),
                SizedBox(height: 5),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: isContainerVisible ? 50 : 0,
                  child: isContainerVisible
                      ? Container(
                          width: 300, // Adjust the desired width
                          height: 50, // Adjust the desired height
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              // Navigate to home page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              // Navigate to game library page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              // Navigate to photo album page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Album()),
              );
            }),
            _buildNavigationButton(Icons.settings, () {
              // Navigate to settings page
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
        size: 30,
        color: Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }
}
