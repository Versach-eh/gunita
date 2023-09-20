import 'package:flutter/material.dart';

void main() {
  runApp(CrosswordApp());
}

class CrosswordApp extends StatefulWidget {
  @override
  _CrosswordAppState createState() => _CrosswordAppState();
}

class _CrosswordAppState extends State<CrosswordApp> {
  final List<String> words = []; // Initialize the words list here

  void addWord(String word) {
    setState(() {
      words.add(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crossword Puzzle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CrosswordScreen(
        words: words,
        onAddWord: addWord,
      ),
    );
  }
}

class CrosswordScreen extends StatefulWidget {
  final List<String> words;
  final Function(String) onAddWord;

  CrosswordScreen({Key? key, required this.words, required this.onAddWord})
      : super(key: key);

  @override
  _CrosswordScreenState createState() => _CrosswordScreenState();
}

class _CrosswordScreenState extends State<CrosswordScreen> {
  final TextEditingController _wordController = TextEditingController();
  List<List<String>>? crossword;

  void _addWord() {
    final word = _wordController.text.trim();
    if (word.isNotEmpty) {
      widget.onAddWord(word);
      _wordController.clear();
    }
  }

  Future<void> _generateCrossword(List<String> words) async {
    // Your crossword generation logic goes here
    // This should be a non-blocking operation

    // For now, we'll simply set a delay to simulate the computation
    await Future.delayed(Duration(seconds: 2));

    // Replace this with your actual crossword grid
    setState(() {
      crossword = _dummyCrossword();
    });
  }

  List<List<String>> _dummyCrossword() {
    return [
      ['H', 'E', 'L', 'L', 'O'],
      ['W', 'O', 'R', 'L', 'D'],
    ];
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 26),
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
              onPressed: () async {
                // Generate and display the crossword puzzle
                await _generateCrossword(widget.words);
                showDialog(
                  context: context,
                  builder: (_) => CrosswordDialog(crossword: crossword),
                );
              },
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
