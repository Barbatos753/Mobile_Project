import 'dart:math';
import 'package:flutter/material.dart';
import 'package:johnnyroudy/FoodGamemode.dart';
import 'Food.dart';

Food carrot = Food(
  image: 'images/carrot.jpg',
  fact: 'Carrots support eye health with beta-carotene.',
);

Food broccoli = Food(
  image: 'images/broccoli.jpg',
  fact: 'Broccoli is high in vitamins K and C for bone health.',
);

Food cucumber = Food(
  image: 'images/cucumber.jpg',
  fact: 'Cucumbers are low-calorie and hydrating for skin health.',
);

Food tomato = Food(
  image: 'images/tomato.jpg',
  fact: 'Tomatoes contain lycopene, an antioxidant for heart health.',
);

Food bellPepper = Food(
  image: 'images/bellpeper.jpg',
  fact: 'Bell peppers provide vitamin A and C for immune support.',
);

Food spinach = Food(
  image: 'images/spinach.jpg',
  fact: 'Spinach is rich in iron and vitamins for energy.',
);

Food lettuce = Food(
  image: 'images/lettuce.jpg',
  fact: 'Lettuce is a low-calorie green that adds crunch to salads.',
);

Food olives = Food(
  image: 'images/olives.jpg',
  fact: 'Olives offer healthy monounsaturated fats for heart health.',
);

Food apple = Food(
  image: 'images/apple.jpg',
  fact: 'Apples, high in fiber, promote digestive health.',
);

Food banana = Food(
  image: 'images/banana.png',
  fact: 'Bananas are potassium-rich for heart and muscle health.',
);

Food orange = Food(
  image: 'images/orange.png',
  fact: 'Oranges are packed with vitamin C for immune support.',
);

Food grape = Food(
  image: 'images/grape.jpg',
  fact: 'Grapes contain antioxidants for overall health.',
);

Food strawberry = Food(
  image: 'images/strawberry.jpg',
  fact: 'Strawberries are rich in vitamin C and antioxidants.',
);

Food watermelon = Food(
  image: 'images/watermelon.jpg',
  fact: 'Watermelons are hydrating fruits with a sweet taste.',
);

Food pineapple = Food(
  image: 'images/pineapple.jpg',
  fact: 'Pineapples are tropical fruits with digestive benefits.',
);

Food coconut = Food(
  image: 'images/coconut.jpg',
  fact: 'Coconuts provide healthy fats and are versatile in cooking.',
);
List<Food> Vegetables=[cucumber,carrot,lettuce,tomato,spinach,olives,bellPepper,broccoli];
List<Food> Fruits=[apple,banana,coconut,pineapple,strawberry,grape,orange,watermelon];
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String difficultyValue = "Select Difficulty";
  String chooseOptionValue = 'Choose Option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/homebackground.jpeg'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Small Image
                Image.asset(
                  'images/gm1.png', // Replace with your small image path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                ),

                SizedBox(height: 20),
                // Difficulty Dropdown
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        items:['Select Difficulty', 'Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            difficultyValue = value !;
                          });
                        },
                        value: difficultyValue,
                      ),
                      SizedBox(width: 60),
                      // Choose Option Dropdown
                      DropdownButton<String>(
                        items: ['Choose Option', 'Choose Right', 'Think Tight']
                            .map((option) => DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            chooseOptionValue = value ?? '';
                          }
                          );
                        },
                        value: chooseOptionValue,
                      ),
                    ]),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  FoodGamemode()));
                  },
                  child: Text('Press Me'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

