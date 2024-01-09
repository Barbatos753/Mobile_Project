class User {
  String username;
  String password;
  DateTime? BirthDate;
  String? gender;
  String role;
  int score;

  User({
    required this.username,
    required this.password,
    required this.BirthDate,
    required this.gender,
    required this.role,
    this.score=0,
  });

}

