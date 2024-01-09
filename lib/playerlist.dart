import 'dart:convert';

import 'package:flutter/material.dart';
import 'user.dart';
import 'package:http/http.dart' as http;

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<User> users=[];
  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController xpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late int editingIndex;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://flipping-categories.000webhostapp.com/getUsers.php"));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print('Response Body: ${response.body} hi this is a response');
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        users = jsonResponse.map((user) {
          return User(
            username: user['username'],
            password: user['password'],
            BirthDate: DateTime.tryParse(user['BirthDate']),
            gender: user['gender'],
            role: user['role'],
            score: user['score'],
          );
        }).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load users');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        child: users.isEmpty
            ? Center(
          child: Text(
            'No users available.',
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            String avatarImage = users[index].gender == 'Strong Boy'
                ? 'images/boyavatar.jpg'
                : 'images/girlavatar.jpg';

            Color backgroundColor = users[index].gender == 'Strong Boy'
                ? Colors.lightBlue
                : Colors.pink;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: backgroundColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(avatarImage),
                  ),
                  title: Text(
                    'Username: ${users[index].username}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Birth Date: ${users[index].BirthDate?.year}-${users[index].BirthDate?.month}-${users[index].BirthDate?.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Age: ${DateTime.now().year-users[index].BirthDate!.year}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Gender: ${users[index].gender}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Password: ${users[index].password}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Role: ${users[index].role}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'XP: ${users[index].score}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      _openEditPopup(index);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  void _openEditPopup(int index) {
    usernameController.text = users[index].username;
    ageController.text = users[index].BirthDate!.year.toString()+'-'+users[index].BirthDate!.month.toString()+'-'+users[index].BirthDate!.day.toString();
    genderController.text = users[index].gender!;
    passwordController.text=users[index].password;
    roleController.text = users[index].role;
    xpController.text = users[index].score.toString();

    editingIndex = index;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context,index),
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
                          users[index].BirthDate != null
                              ? "${users[index].BirthDate!.toLocal()}".split(' ')[0]
                              : 'Select Date',
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: genderController.text,
                  items: ['Pretty Girl','Strong Boy']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      genderController.text = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                if (users[index].role != 'admin') // Disable role editing for admins
                  DropdownButtonFormField<String>(
                    value: roleController.text,
                    items: ['admin','player']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        roleController.text = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Role'),
                  ),
                TextField(
                  controller: xpController,
                  decoration: InputDecoration(labelText: 'XP'),
                ),
              ],
            ),
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
                _saveChanges();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _selectDate(BuildContext context,int index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: users[editingIndex].BirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != users[index].BirthDate) {
      setState(() {
        users[index].BirthDate = pickedDate;
      });
    }
  }
  void _saveChanges() {
    setState(() {
      users[editingIndex].username = usernameController.text;
      users[editingIndex].gender = genderController.text;
      users[editingIndex].password=passwordController.text;
      users[editingIndex].role = roleController.text;
      users[editingIndex].score = int.tryParse(xpController.text) ?? 0;
      _updateUserData(users[editingIndex]);
    });
  }
  Future<void> _updateUserData(User updatedUser) async {
    final String apiUrl = "https://flipping-categories.000webhostapp.com/updateUserData.php";

    final Map<String, dynamic> data = {
      'username': updatedUser.username,
      'gender': updatedUser.gender,
      'password': updatedUser.password,
      'role': updatedUser.role,
      'xp': updatedUser.score,
      'BirthDate': updatedUser.BirthDate?.toLocal().toString(), // Convert DateTime to String
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Successfully updated data
      print('Data updated successfully');
    } else {
      // Failed to update data
      print('Failed to update data. Status code: ${response.statusCode}');
    }
  }
}
