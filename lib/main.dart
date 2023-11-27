import 'package:flutter/material.dart';
import 'package:untitled/gamemode1.dart';
import 'Food.dart';
import 'gamemode2.dart';

Food carrot = Food(
  image: 'images/carrot.jpg',
  fact: ' support eye health with beta-carotene.',
);

Food broccoli = Food(
  image: 'images/broccoli.jpg',
  fact: ' is high in vitamins K and C for bone health.',
);

Food cucumber = Food(
  image: 'images/cucumber.jpg',
  fact: ' are low-calorie and hydrating for skin health.',
);

Food tomato = Food(
  image: 'images/tomato.jpg',
  fact: ' contain lycopene, an antioxidant for heart health.',
);

Food bellPepper = Food(
  image: 'images/bellpeper.jpg',
  fact: ' provide vitamin A and C for immune support.',
);

Food spinach = Food(
  image: 'images/spinach.jpg',
  fact: ' is rich in iron and vitamins for energy.',
);

Food lettuce = Food(
  image: 'images/lettuce.jpg',
  fact: ' is a low-calorie green that adds crunch to salads.',
);

Food olives = Food(
  image: 'images/olives.jpg',
  fact: ' offer healthy monounsaturated fats for heart health.',
);

Food apple = Food(
  image: 'images/apple.jpg',
  fact: ' high in fiber, promote digestive health.',
);

Food banana = Food(
  image: 'images/banana.png',
  fact: ' are potassium-rich for heart and muscle health.',
);

Food orange = Food(
  image: 'images/orange.png',
  fact: ' are packed with vitamin C for immune support.',
);

Food grape = Food(
  image: 'images/grape.jpg',
  fact: ' contain antioxidants for overall health.',
);

Food strawberry = Food(
  image: 'images/strawberry.jpg',
  fact: ' are rich in vitamin C and antioxidants.',
);

Food watermelon = Food(
  image: 'images/watermelon.jpg',
  fact: ' are hydrating fruits with a sweet taste.',
);

Food pineapple = Food(
  image: 'images/pineapple.jpg',
  fact: ' are tropical fruits with digestive benefits.',
);

Food coconut = Food(
  image: 'images/coconut.jpg',
  fact: ' provide healthy fats and are versatile in cooking.',
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
  String fruitOrVegetable = '';
  String gamemodepic = "images/gm1.png";
  int difficultyLevel = 0;
  String userName = '';
  String userGender = '';
  bool isDarkMode = false;

  void chooseLevel() {
    if (difficultyValue == 'Easy') {
      difficultyLevel = 2;
    } else if (difficultyValue == 'Medium') {
      difficultyLevel = 3;
    } else if (difficultyValue == 'Hard') {
      difficultyLevel = 4;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Use the context from the build method
      showNameDialog(context);
    });
  }

  void showNameDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text('Enter Your Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(isDarkMode ? 'images/darkbackground.jpeg' : 'images/homebackground.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              // Checkbox for Dark Mode
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value ?? false;
                        });
                      },
                    ),
                    Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny, color: Colors.white),
                  ],
                ),
              ),
              // User Info Display

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Hello, $userName !',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              // Game Mode Image
              Image.asset(
                gamemodepic,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dropdown for Difficulty
                  DropdownButton<String>(
                    items: ['Select Difficulty', 'Easy', 'Medium', 'Hard']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: isDarkMode? Colors.red:Colors.black),),
                      );
                    })
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        difficultyValue = value!;
                        chooseLevel();
                      });
                    },
                    value: difficultyValue,
                  ),
                  SizedBox(width: 60),
                  // Dropdown for Choose Option
                  DropdownButton<String>(
                    items: ['Choose Option', 'Choose Right', 'Think Tight']
                        .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option,style: TextStyle(color: isDarkMode? Colors.red:Colors.black)),
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        chooseOptionValue = value ?? '';
                        if (chooseOptionValue == 'Choose Right')
                          gamemodepic = 'images/gm1.png';
                        else if (chooseOptionValue == 'Think Tight')
                          gamemodepic = 'images/gm2.png';
                      });
                    },
                    value: chooseOptionValue,
                  ),
                ],
              ),
              // Start Button
              ElevatedButton(
                onPressed: () {
                  if (difficultyValue != 'Select Difficulty') {
                    if (chooseOptionValue == 'Think Tight')
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => gamemode2(difficultyLevel: difficultyLevel,)));
                    else if (chooseOptionValue == 'Choose Right')
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FoodGamemode(difficultyValue: difficultyValue)));
                    else
                      gmError(context);
                  } else {
                    diffError(context);
                  }
                },
                child: Text('Start'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Adjust padding as needed
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void diffError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a difficulty'),
          content: Text('Please select a difficulty level.'),
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

  void gmError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a gamemode'),
          content: Text('Please select a gamemode.'),
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
