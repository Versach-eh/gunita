import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/foundation.dart';


void main() {
  runApp(CrosswordApp());
}

class CrosswordApp extends StatefulWidget {
  @override
  _CrosswordAppState createState() => _CrosswordAppState();
}

class _CrosswordAppState extends State<CrosswordApp> {
  final List<String> words = [];
  List<List<String>>? crossword;

  void addWord(String word) {
    setState(() {
      words.add(word);
    });
  }

  Future<void> generateCrossword(List<String> words) async {
    // Start generating the crossword in a background isolate
    final generatedCrossword = await _generateCrosswordGrid(words);

    setState(() {
      crossword = generatedCrossword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crossword Puzzle Game',
      theme: ThemeData(
        primaryColor: const Color(0xff4530B2),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CrosswordScreen(
        words: words,
        onAddWord: addWord,
        onGenerateCrossword: generateCrossword,
        crossword: crossword,
      ),
    );
  }
}

class CrosswordScreen extends StatefulWidget {
  final List<String> words;
  final Function(String) onAddWord;
  final Function(List<String>) onGenerateCrossword;
  final List<List<String>>? crossword;

  CrosswordScreen({
    Key? key,
    required this.words,
    required this.onAddWord,
    required this.onGenerateCrossword,
    required this.crossword,
  }) : super(key: key);

  @override
  _CrosswordScreenState createState() => _CrosswordScreenState();
}

class _CrosswordScreenState extends State<CrosswordScreen> {
  final TextEditingController _wordController = TextEditingController();

  void _addWord() {
    final word = _wordController.text.trim();
    if (word.isNotEmpty) {
      widget.onAddWord(word);
      _wordController.clear();
    }
  }

  Future<void> _generateCrossword() async {
    // Call the generateCrossword function with the current list of words
    await widget.onGenerateCrossword(widget.words);
    showDialog(
      context: context,
      builder: (_) => CrosswordDialog(crossword: widget.crossword),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crossword Puzzle'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _wordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Enter a word',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: _addWord,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.words.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    widget.words[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _generateCrossword, // Updated onPressed
              child: const Text(
                'Generate Crossword',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CrosswordDialog extends StatelessWidget {
  final List<List<String>>? crossword;

  CrosswordDialog({required this.crossword});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Generated Crossword'),
      content: Column(
        children: [
          if (crossword != null)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossword![0].length,
              ),
              itemBuilder: (context, index) {
                final row = index ~/ crossword![0].length;
                final col = index % crossword![0].length;
                final cellValue = crossword![row][col];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      cellValue,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              itemCount: crossword!.length * crossword![0].length,
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

// Define the crossword generation function outside of the state class
List<List<String>> _generateCrosswordGrid(List<String> words) {
  final grid = List.generate(10, (_) => List.filled(10, ''));

  final random = Random();

  // Attempt to place each word until successful or too many attempts
  for (final word in words) {
    var attempts = 0;
    while (attempts < 10) {
      final isHorizontal = random.nextBool();
      if (isHorizontal) {
        final row = random.nextInt(10);
        final col = random.nextInt(10 - word.length + 1);
        if (_canPlaceWordHorizontally(grid, row, col, word)) {
          _placeWordHorizontally(grid, row, col, word);
          break;
        }
      } else {
        final row = random.nextInt(10 - word.length + 1);
        final col = random.nextInt(10);
        if (_canPlaceWordVertically(grid, row, col, word)) {
          _placeWordVertically(grid, row, col, word);
          break;
        }
      }
      attempts++;
    }
  }

  // Fill in empty cells with random letters
  for (var i = 0; i < grid.length; i++) {
    for (var j = 0; j < grid[i].length; j++) {
      if (grid[i][j].isEmpty) {
        grid[i][j] = String.fromCharCode(Random().nextInt(26) + 65);
      }
    }
  }

  return grid;
}

bool _canPlaceWordHorizontally(List<List<String>> grid, int row, int col, String word) {
  for (var i = 0; i < word.length; i++) {
    if (grid[row][col + i].isNotEmpty && grid[row][col + i] != word[i]) {
      return false;
    }
  }
  return true;
}

void _placeWordHorizontally(List<List<String>> grid, int row, int col, String word) {
  for (var i = 0; i < word.length; i++) {
    grid[row][col + i] = word[i];
  }
}

bool _canPlaceWordVertically(List<List<String>> grid, int row, int col, String word) {
  for (var i = 0; i < word.length; i++) {
    if (grid[row + i][col].isNotEmpty && grid[row + i][col] != word[i]) {
      return false;
    }
  }
  return true;
}

void _placeWordVertically(List<List<String>> grid, int row, int col, String word) {
  for (var i = 0; i < word.length; i++) {
    grid[row + i][col] = word[i];
  }
}