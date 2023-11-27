import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Food.dart';


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


  List<Food> combinedItems = [];
  Food selectedItem=Food(image: '', fact: '') ;
  @override
  void initState() {
    super.initState();
    _combineItems();
    _chooseRandomItem();
  }

  void _combineItems() {
    combinedItems = [...Fruits, ...Vegetables];
  }

  void _chooseRandomItem() {
    setState(() {
      selectedItem = combinedItems[Random().nextInt(combinedItems.length)];
      _generateRandomFacts();
    });
  }

  void _generateRandomFacts() {
    facts = [selectedItem.fact];
    List<Food> allItems = [...Fruits, ...Vegetables];
    allItems.remove(selectedItem);
    for (Food i in allItems) {
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
                      selectedItem.image,
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
