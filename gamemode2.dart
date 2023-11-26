import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<Item> fruits = [
    Item('Apple', 'Fruit', 'images/apple.jpg', 'Fact about Apple'),
    Item('Banana', 'Fruit', 'images/banana.png', 'Fact about Banana'),
    Item('coconut', 'Fruit', 'images/coconut.jpg', 'Fact about coconut'),
    Item('grape', 'Fruit', 'images/grape.jpg', 'Fact about grape'),
    Item('orange', 'Fruit', 'images/orange.jpg', 'Fact about orange'),
    Item('pineapple', 'Fruit', 'images/pineapple.jpg', 'Fact about pineapple'),
    Item('strawberry', 'Fruit', 'images/strawberry.jpg', 'Fact about strawberry'),
    Item('watermelon', 'Fruit', 'images/watermelon.jpg', 'Fact about watermelon'),
  ];

  final List<Item> vegetables = [
    Item('Carrot', 'Vegetable', 'images/carrot.jpg', 'Fact about Carrot'),
    Item('bellpeper', 'Vegetable', 'images/bellpeper.jpg', 'Fact about bellpeper'),
    Item('broccoli', 'Vegetable', 'images/broccoli.jpg', 'Fact about broccoli'),
    Item('cucumber', 'Vegetable', 'images/cucumber.jpg', 'Fact about cucumber'),
    Item('lettuce', 'Vegetable', 'images/lettuce.jpg', 'Fact about lettuce'),
    Item('olives', 'Vegetable', 'images/olives.jpg', 'Fact about olives'),
    Item('spinach', 'Vegetable', 'images/spinach.jpg', 'Fact about spinach'),
    Item('tomato', 'Vegetable', 'images/tomato.jpg', 'Fact about tomato'),
  ];

  List<Item> combinedItems = [];
  Item selectedItem = Item('', '', '', '');

  @override
  void initState() {
    super.initState();
    _combineItems();
    _chooseRandomItem();
  }

  void _combineItems() {
    combinedItems = [...fruits, ...vegetables];
  }

  void _chooseRandomItem() {
    setState(() {
      selectedItem = combinedItems[Random().nextInt(combinedItems.length)];
      _generateRandomFacts();
    });
  }

  void _generateRandomFacts() {
    facts = [selectedItem.fact];
    for (int i = 0; i < 3; i++) {
      facts.add(_getRandomIncorrectFact());
    }
    facts.shuffle();
  }

  String _getRandomIncorrectFact() {
    List<Item> allItems = [...fruits, ...vegetables];
    allItems.remove(selectedItem);
    return allItems[Random().nextInt(allItems.length)].fact;
  }

  List<String> facts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Think Tight'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/gm2background.jpeg'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display Item Image
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      selectedItem.imagePath,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display Facts
                  Column(
                    children: facts.map((fact) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _checkAnswer(fact);
                          },
                          child: Text(fact),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(String selectedFact) {
    setState(() {
      if (selectedFact == selectedItem.fact) {
        _showToast('Correct Answer!');
      } else {
        _showToast('Incorrect Answer! The correct answer is: ${selectedItem.fact}');
      }
      _chooseRandomItem();
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class Item {
  final String name;
  final String category;
  final String imagePath;
  final String fact;

  Item(this.name, this.category, this.imagePath, this.fact);
}
