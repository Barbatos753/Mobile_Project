import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';


class gamemode2 extends StatefulWidget {
  final int difficultyLevel;

  gamemode2({required this.difficultyLevel});
  @override
  gamemode2state createState() => gamemode2state(difficultyLevel:difficultyLevel);


}

class gamemode2state extends State<gamemode2> {
  int difficultyLevel;
  int count=1;
  gamemode2state({required this.difficultyLevel});
  final List<Item> fruits = [
    Item('Apple', 'Fruit', 'images/apple.jpg', 'High in fiber, promote digestive health.'),
    Item('Banana', 'Fruit', 'images/banana.png', 'Are potassium-rich for heart and muscle health.'),
    Item('coconut', 'Fruit', 'images/coconut.jpg', 'Provide healthy fats and are versatile in cooking.'),
    Item('grape', 'Fruit', 'images/grape.jpg', 'Contain antioxidants for overall health.'),
    Item('orange', 'Fruit', 'images/orange.png', 'Are packed with vitamin C for immune support.'),
    Item('pineapple', 'Fruit', 'images/pineapple.jpg', 'Are tropical fruits with digestive benefits.'),
    Item('strawberry', 'Fruit', 'images/strawberry.jpg', 'Are rich in vitamin C and antioxidants.'),
    Item('watermelon', 'Fruit', 'images/watermelon.jpg', 'Are hydrating fruits with a sweet taste.'),
  ];

  final List<Item> vegetables = [
    Item('Carrot', 'Vegetable', 'images/carrot.jpg', 'support eye health with beta-carotene'),
    Item('bellpeper', 'Vegetable', 'images/bellpeper.jpg', 'provide vitamin A and C for immune support.'),
    Item('broccoli', 'Vegetable', 'images/broccoli.jpg', 'is high in vitamins K and C for bone health.'),
    Item('cucumber', 'Vegetable', 'images/cucumber.jpg', 'are low-calorie and hydrating for skin health.'),
    Item('lettuce', 'Vegetable', 'images/lettuce.jpg', 'is a low-calorie green that adds crunch to salads.'),
    Item('olives', 'Vegetable', 'images/olives.jpg', 'offer healthy monounsaturated fats for heart health.'),
    Item('spinach', 'Vegetable', 'images/spinach.jpg', 'is rich in iron and vitamins for energy.'),
    Item('tomato', 'Vegetable', 'images/tomato.jpg', 'contain lycopene, an antioxidant for heart health.'),
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
    List<Item> allItems = [...fruits, ...vegetables];
    allItems.remove(selectedItem);
    for (Item f in allItems) {
      String f=allItems[Random().nextInt(allItems.length)].fact;
      if(!facts.contains(f))
        facts.add(f);
      if(facts.length==difficultyLevel+1)
        break;
    }
    facts.shuffle();
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
                  Text(
                    'Think Tight: Level $count',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            if (fact == selectedItem.fact) {
                              count++;
                              if (count <= 5) {
                                showResultMessage(true);
                              } else
                                showmax(context);
                            } else {
                              showResultMessage(false);
                              count = 1;
                            }},
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

  void showResultMessage(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(isCorrect ? 'Correct Answer!' : 'Wrong Answer!'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  List<Item> combinedItems = [];
                  Item selectedItem = Item('', '', '', '');
                  _chooseRandomItem();
                });

                Navigator.pop(context);
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }
  void showmax(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Won!'),
          content: Text('You Completed This Level, Congrats!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
              },
              child: Text('Go to Home Page'),
            ),
          ],
        );
      },
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
