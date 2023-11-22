import 'package:flutter/material.dart';

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
                SizedBox(height: 10),
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

                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print('Button Pressed');
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
