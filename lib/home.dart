import 'package:flutter/material.dart';
import 'gamemode1.dart';
import 'gamemode2.dart';
import 'user.dart';
import 'login.dart';
class MyPage extends StatefulWidget {
  User user;
  MyPage({super.key,required this.user});

  @override
  MyPageState createState() => MyPageState(user: user);
}

class MyPageState extends State<MyPage> {
  User user;
  MyPageState({required this.user});
  int xp=0;
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
                  'Hello, ${user.username} !\n Your current xp is : ${user.score}',
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
                              builder: (context) => gamemode2(difficultyLevel: difficultyLevel,user:user)));
                    else if (chooseOptionValue == 'Choose Right')
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FoodGamemode(difficultyValue: difficultyValue,user:user)));
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
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login page
                    );
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
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