import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';
import 'Food.dart';

class FoodGamemode extends StatefulWidget {
  final String difficultyValue;
  FoodGamemode({required this.difficultyValue});
  @override
  FoodGamemodeState createState() => FoodGamemodeState(difficultyValue: difficultyValue);
}

class FoodGamemodeState extends State<FoodGamemode> {
  List<Food> options = [];
  Food correctAnswer = Food(image: '',fact: '');
  String correctfact='';
  int count = 1;
  final String difficultyValue;
  String fruitOrVegetable = '';
  FoodGamemodeState({required this.difficultyValue});

  @override
  void initState() {
    super.initState();
    startNewLevel();
  }

  void startNewLevel() {
    options = [];
    fruitOrVegetable = ['Fruit', 'Vegetable'][Random().nextInt(2)];
    Fruits.shuffle();
    Vegetables.shuffle();

    if (fruitOrVegetable == 'Fruit') {
      if (difficultyValue == 'Easy') {
        options.add(Fruits[Random().nextInt(Fruits.length)]);
        for (Food item in Vegetables) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 4) {
            break;
          }
        }
      } else if (difficultyValue == 'Medium') {
        options.add(Fruits[Random().nextInt(Fruits.length)]);
        for (Food item in Vegetables) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 6) {
            break;
          }
        }
      } else if (difficultyValue == 'Hard') {
        options.add(Fruits[Random().nextInt(Fruits.length)]);
        for (Food item in Vegetables) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 8) {
            break;
          }
        }
      }
    } else {
      if (difficultyValue == 'Easy') {
        options.add(Vegetables[Random().nextInt(Vegetables.length)]);
        for (Food item in Fruits) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 4) {
            break;
          }
        }
      }
      if (difficultyValue == 'Medium') {
        options.add(Vegetables[Random().nextInt(Vegetables.length)]);
        for (Food item in Fruits) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 6) {
            break;
          }
        }
      }
      if (difficultyValue == 'Hard') {
        options.add(Vegetables[Random().nextInt(Vegetables.length)]);
        for (Food item in Fruits) {
          if (!options.contains(item)) {
            options.add(item);
          }
          if (options.length == 8) {
            break;
          }
        }
      }
    }
    correctAnswer = options[0];
    correctfact=correctAnswer.fact;
    options.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Right'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back2.webp'), // Replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose The $fruitOrVegetable: Level $count',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: options.sublist(0, options.length ~/ 2).map((option) {
                        return buildImageContainer(option);
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: options.sublist(options.length ~/ 2).map((option) {
                        return buildImageContainer(option);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer(Food option) {
    return InkWell(
      onTap: () {
        if (option == correctAnswer) {
          count++;
          if (count <= 5) {
            showResultMessage(true);
          } else
            showmax(context);
        } else {
          showResultMessage(false);
          count = 1;
        }
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            option.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void showResultMessage(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(isCorrect ? 'Correct Answer!\n$correctfact' : 'Wrong Answer!'),
          actions: [
            TextButton(
              onPressed: () {
                startNewLevel();
                setState(() {

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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyPage()));
              },
              child: Text('Go to main'),
            ),
          ],
        );
      },
    );
  }
}