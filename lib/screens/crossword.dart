// import 'package:flutter/material.dart';

// void main() {
//   runApp(const CrosswordApp());
// }

// class CrosswordApp extends StatelessWidget {
//   final List<String> words = [];

//   const CrosswordApp({super.key});

//   void addWord(String word) {
//     words.add(word);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crossword Puzzle Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: CrosswordScreen(
//         words: words,
//         onAddWord: addWord,
//       ),
//     );
//   }
// }

// class CrosswordScreen extends StatefulWidget {
//   final List<String> words;
//   final Function(String) onAddWord;

//   const CrosswordScreen({super.key, required this.words, required this.onAddWord});

//   @override
//   _CrosswordScreenState createState() => _CrosswordScreenState();
// }

// class _CrosswordScreenState extends State<CrosswordScreen> {
//   final TextEditingController _wordController = TextEditingController();

//   void _addWord() {
//     final word = _wordController.text.trim();
//     if (word.isNotEmpty) {
//       widget.onAddWord(word);
//       _wordController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crossword Puzzle'),
//         elevation: 0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color: Colors.blue,
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _wordController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       labelText: 'Enter a word',
//                       labelStyle: TextStyle(color: Colors.white70),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                   onPressed: _addWord,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.words.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     widget.words[index],
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Generate and display the crossword puzzle
//                 final crossword = _generateCrossword(widget.words);
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                     title: const Text('Generated Crossword'),
//                     content: SizedBox(
//                       width: double.maxFinite,
//                       child: SingleChildScrollView(
//                         child: _buildCrosswordGrid(crossword),
//                       ),
//                     ),
//                     actions: [
//                       ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('Close'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Generate Crossword',
//                 style: TextStyle(fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCrosswordGrid(List<List<String>> crossword) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossword.length,
//       ),
//       itemBuilder: (context, index) {
//         final row = index ~/ crossword.length;
//         final col = index % crossword.length;
//         final cellValue = crossword[row][col];
//         return Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: Center(
//             child: Text(
//               cellValue,
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         );
//       },
//       itemCount: crossword.length * crossword.length,
//     );
//   }
// }

// List<List<String>> _generateCrossword(List<String> words) {
//   // Generate the crossword puzzle grid logic based on the input words
//   // You can implement your own crossword generation algorithm here
//   // For simplicity, this example just creates a square grid with words horizontally

//   final crossword =
//       List.generate(words.length, (_) => List.filled(words.length, ''));

//   for (int i = 0; i < words.length; i++) {
//     final word = words[i];
//     final row = words.length ~/ 2;
//     final col = (words.length - word.length) ~/ 2;
//     for (int j = 0; j < word.length; j++) {
//       crossword[row][col + j] = word[j];
//     }
//   }

//   return crossword;
// }
