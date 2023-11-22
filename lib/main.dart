import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Difficulty selectedDifficulty = Difficulty.easy;
  GameMode selectedGameMode = GameMode.both;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit and Vegetable Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Difficulty>(
              value: selectedDifficulty,
              onChanged: (Difficulty? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedDifficulty = newValue;
                  });
                }
              },
              items: Difficulty.values.map<DropdownMenuItem<Difficulty>>(
                    (Difficulty difficulty) {
                  return DropdownMenuItem<Difficulty>(
                    value: difficulty,
                    child: Text(difficultyToString(difficulty)),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<GameMode>(
              value: selectedGameMode,
              onChanged: (GameMode? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedGameMode = newValue;
                  });
                }
              },
              items: GameMode.values.map<DropdownMenuItem<GameMode>>(
                    (GameMode mode) {
                  return DropdownMenuItem<GameMode>(
                    value: mode,
                    child: Text(gameModeToString(mode)),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameModePage(
                      mode: selectedGameMode,
                      difficulty: difficultyToValue(selectedDifficulty),
                    ),
                  ),
                );
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }

  String difficultyToString(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
      default:
        return 'Difficulty';
    }
  }

  String gameModeToString(GameMode mode) {
    switch (mode) {
      case GameMode.both:
        return 'Both';
      case GameMode.fruit:
        return 'Fruit';
      case GameMode.vegetable:
        return 'Vegetable';
      case GameMode.fact:
        return 'Fact';
    }
  }

  int difficultyToValue(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return 4;
      case Difficulty.medium:
        return 6;
      case Difficulty.hard:
        return 8;
      default:
        return 4;
    }
  }
}

class Difficulty {
  final String name;
  final int value;

  const Difficulty._(this.name, this.value);

  static const Difficulty easy = Difficulty._('Easy', 4);
  static const Difficulty medium = Difficulty._('Medium', 6);
  static const Difficulty hard = Difficulty._('Hard', 8);

  static List<Difficulty> get values => [easy, medium, hard];

  @override
  String toString() => name;
}

enum GameMode { both, fruit, vegetable, fact }

class GameModePage extends StatefulWidget {
  final GameMode mode;
  final int difficulty;

  GameModePage({required this.mode, required this.difficulty});

  @override
  _GameModePageState createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  List<String> fruits = [
    'apple',
    'banana',
    'orange',
    'grape',
    'strawberry',
    'watermelon',
    'pineapple',
    'coconut',
  ];

  List<String> vegetables = [
    'carrot',
    'broccoli',
    'cucumber',
    'tomato',
    'bell_pepper',
    'spinach',
    'lettuce',
    'olives',
  ];

  List<String> facts = [
    'Apples are a good source of fiber.',
    'Bananas are rich in potassium.',
    'Oranges are high in vitamin C.',
    'Grapes are rich in antioxidants.',
    'Strawberries are low in calories.',
    'Watermelons are hydrating fruits.',
    'Carrots are rich in beta-carotene.',
    'Broccoli is high in vitamins K and C.',
    'Cucumbers are low in calories.',
    'Tomatoes are rich in lycopene.',
    'Bell peppers are a good source of vitamin A.',
    'Spinach is high in iron and calcium.',
  ];

  @override
  Widget build(BuildContext context) {
    int difficulty = widget.difficulty;
    List<String> items = getItems(difficulty);
    items.shuffle(); // Shuffle the items

    String correctAnswer = items[Random().nextInt(items.length)]; // Random correct answer
    String fact = facts[Random().nextInt(facts.length)]; // Random fact

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == GameMode.fruit
              ? 'Fruit Mode'
              : (widget.mode == GameMode.vegetable
              ? 'Vegetable Mode'
              : (widget.mode == GameMode.fact ? 'Fact Mode' : 'Both Mode')),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.mode == GameMode.fruit || widget.mode == GameMode.vegetable)
            Text(
              widget.mode == GameMode.fruit
                  ? 'Choose the Right Fruit'
                  : 'Choose the Right Vegetable',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          if (widget.mode == GameMode.fact)
            Text(
              'Choose the Correct Fact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          if (widget.mode == GameMode.both)
            Text(
              'Choose the Right Item or Fact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items.length,
                  (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (items[index] == correctAnswer || items[index] == fact) {
                      _showResultMessage('Correct Answer!');
                    } else {
                      _showResultMessage('Wrong Answer!');
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: widget.mode == GameMode.fact
                          ? AssetImage('assets/question_mark.jpg')
                          : AssetImage('assets/${items[index]}.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: widget.mode == GameMode.fact
                      ? Center(
                    child: Text(
                      'Fact ${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Container(),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_resultMessage.isNotEmpty)
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _resultMessage == 'Correct Answer!'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  String _resultMessage = '';

  void _showResultMessage(String message) {
    setState(() {
      _resultMessage = message;
    });
  }

  List<String> getItems(int difficulty) {
    List<String> items = [];
    switch (widget.mode) {
      case GameMode.both:
        items = _getRandomItems([...fruits, ...vegetables, ...facts], difficulty);
        break;
      case GameMode.fruit:
        items = _getRandomItems(fruits, difficulty);
        break;
      case GameMode.vegetable:
        items = _getRandomItems(vegetables, difficulty);
        break;
      case GameMode.fact:
        items = _getRandomItems(facts, difficulty);
        break;
    }
    return items;
  }

  List<String> _getRandomItems(List<String> sourceList, int difficulty) {
    List<String> items = [];
    if (difficulty >= sourceList.length) {
      items = List.from(sourceList);
    } else {
      items = List.from(sourceList)..shuffle();
      items = items.sublist(0, difficulty);
    }
    return items;
  }
}
