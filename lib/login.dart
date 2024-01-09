import 'package:flutter/material.dart';
import 'mainadmin.dart';
import 'user.dart';
import 'registration.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<User> authenticateUser(String username, String password) async {
    final  url = 'https://flipping-categories.000webhostapp.com/login.php'; // Replace with your actual backend endpoint


    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Assuming your backend sends a 'success' status when authentication is successful
        if (responseData['status'] == 'success') {
          // Parse user data from the response and return the actual user
          User authenticatedUser = User(
            username: responseData['username'],
            password: responseData['password'],
            BirthDate: responseData['age'],
            gender: responseData['gender'],
            role: responseData['role'],
            score: responseData['score'] ?? 0, // Assuming 'xp' is an optional field
          );
          return authenticatedUser;
        }
      } else {
        print('Authentication failed. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during authentication: $e');
    }

    // Return a user object with default or empty values
    return User(
      username: '',
      password: '',
      BirthDate: DateTime(2022, 1, 1),
      gender: '',
      role: '',
      score: 0,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          obscureText: !isPasswordVisible,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;

                    User existingUser = await authenticateUser(username,password);

                    if (existingUser.username!='') {


                      if (existingUser.role == 'admin')
                        Navigator.push(context, MaterialPageRoute(builder: (context) => adminPage(user: existingUser,)));
                      else
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage(user: existingUser,)));
                    } else {
                      showErrorDialog(context);

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                  },
                  child: Text("Don't have an account? Register now"),
                ),
              ],
            ),
            ),
        );
    }
}