import 'package:flutter/material.dart';
import 'package:untitled/gamemode1.dart';
import 'Food.dart';
import 'gamemode2.dart';

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
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  String difficultyValue = "Select Difficulty";
  String chooseOptionValue = 'Choose Option';
  String fruitOrVegetable='';
  String gamemodepic = "images/gm1.png";
  int difficultyLevel=0;
  void chooselevel(){

    if (difficultyValue == 'Easy') {
      difficultyLevel=2;
    }else if (difficultyValue == 'Medium') {
      difficultyLevel=3;
    }else if (difficultyValue == 'Hard') {
      difficultyLevel=4;
    }
  }

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

                Image.asset(
                  gamemodepic,
                  width: 200,
                  height: 200,
                ),

                SizedBox(height: 20),
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
                            chooselevel();
                          });
                        },
                        value: difficultyValue,
                      ),
                      SizedBox(width: 60),
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
                            if(chooseOptionValue=='Choose Right')
                              gamemodepic='images/gm1.png';
                            else if(chooseOptionValue=='Think Tight')
                              gamemodepic='images/gm2.png';
                          }
                          );
                        },
                        value: chooseOptionValue,
                      ),
                    ]),
                ElevatedButton(
                  onPressed: () {
                    if(difficultyValue!='Select Difficulty') {
                      if (chooseOptionValue == 'Think Tight')
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                gamemode2(difficultyLevel: difficultyLevel,)));
                      if (chooseOptionValue == 'Choose Right')
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                FoodGamemode(
                                  difficultyValue: difficultyValue,)));
                    }
                    else{differror(context);

                    }
                  },
                  child: Text('Start'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Adjust padding as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void differror(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose a dificulty'),
          content: Text('now'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
