// INCORPORATE JASPER'S DESIGN
// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/create_album_screen.dart';
// import 'package:gunita20/screens/gamelibrary_screen.dart';
// import 'package:gunita20/screens/home_screen.dart';
// import 'package:gunita20/screens/settings/settings_screen.dart';


// class Album extends StatefulWidget {
//   @override
//   _AlbumState createState() => _AlbumState();
// }

// class _AlbumState extends State<Album> {
//   int _hoveredIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateAlbum(),
//             ),
//           );
//         },
//         child: Container(
//           color: Color(0xff4f22cd),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: MediaQuery.of(context).size.height * 0.40,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 0.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   child: Column(children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Text(
//                         'Your Memories',
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff3b0d6b),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CreateAlbum()),
//                         );
//                       },
//                       child: Text(
//                         "Create Album",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xff4f22cd),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         minimumSize: Size(300, 60),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
//               Positioned.fill(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text(
//                           'Teresa Stonesteel',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xfffffeff),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(1.0),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildNavigationButton(Icons.home, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => HomeScreen(),
//                               ),
//                             );
//                           }),
//                           _buildNavigationButton(Icons.games, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => GameLibrary(),
//                               ),
//                             );
//                           }),
//                           _buildNavigationButton(Icons.photo_album, () {
//                             Navigator.pushReplacementNamed(
//                               context,
//                               '/photo_album',
//                             );
//                           }),
//                           _buildNavigationButton(Icons.settings, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Settings()),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         size: 30,
//         color: Color(0xff959595),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// albums_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/add_album_screen.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/create_album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'package:gunita20/services/firebase_service.dart';

class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  final FirebaseService firebaseService = FirebaseService();
  List<MyAlbum> albums = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _getUser() async {
    return _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    final List<MyAlbum> loadedAlbums = await firebaseService.getAlbums();
    setState(() {
      albums = loadedAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Color(0xff4f22cd).withOpacity(0.5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FutureBuilder<User?>(
                      future: _getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            return AlbumList(currentUser: snapshot.data!);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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
              child: FutureBuilder<User?>(
                future: _getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xff959595), // Adjust the border color as needed
                                width: 4.0,
                              ),
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.photo,
                              size: 80,
                              color: Color(0xff959595), // Adjust the icon color as needed
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Test123",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Age:",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Sex:",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAlbumScreen(),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Color(0xff4f22cd),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.add),
        SizedBox(width: 8),
        Text(
          'Create Album',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),


      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              _onTabTapped(0);
            }),
            _buildNavigationButton(Icons.games, () {
              _onTabTapped(1);
            }),
            _buildNavigationButton(Icons.photo_album, () {}),
            _buildNavigationButton(Icons.settings, () {
              _onTabTapped(3);
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
        color: Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameLibrary(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAlbum(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MySettings(),
          ),
        );
        break;
      default:
        break;
    }
  }
}

class AlbumList extends StatelessWidget {
  final User currentUser;

  const AlbumList({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users/${currentUser.uid}/albums')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final albums = snapshot.data!.docs
              .map((doc) => MyAlbum(id: doc.id, title: doc['title'], imageUrls: []))
              .toList();
          return ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return ListTile(
                title: Text(
                  album.title,
                  style: TextStyle(fontSize: 25.0),
                ),
                shape: Border(
                  bottom: BorderSide(),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AlbumImagesScreen(currentUser: currentUser, album: album),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
