import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'home.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? gender;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _sendDataToBackend() async {
    final String url = 'https://flipping-categories.000webhostapp.com/register.php'; // Replace with your actual backend endpoint

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'BirthDate': selectedDate != null ? selectedDate!.toString() : '',
          'gender': gender ?? '',
          'role':'player',
          'score':0,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          print('Registration successful');
          User existingUser=User(username: _usernameController.text, password: _passwordController.text , gender: gender ?? '', role: 'player', BirthDate: selectedDate);
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage(user: existingUser,)));
        } else if (responseData['status'] == 'error' &&
            responseData['message'] == 'Username already exists') {
          print('Username already exists. Please try another.');
        } else {
          print('Failed to register. ${responseData['message']}');
        }
      } else {
        print('Failed to send data to backend. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registration',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true, // to hide the password
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: gender,
                items: ['Pretty Girl', 'Strong Boy'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate != null
                            ? "${selectedDate!.toLocal()}".split(' ')[0]
                            : 'Select Date',
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _sendDataToBackend();
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}