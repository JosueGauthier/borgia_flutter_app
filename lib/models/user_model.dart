class UserModel {
  int? id;
  String? username;
  String? lastName;
  String? firstName;
  String? password;
  String? email;
  Null? surname;
  Null? family;
  String? balance;
  Null? year;
  Null? campus;
  Null? phone;
  Null? avatar;
  Null? theme;

  UserModel(
      {this.id,
      this.username,
      this.lastName,
      this.firstName,
      this.password,
      this.email,
      this.surname,
      this.family,
      this.balance,
      this.year,
      this.campus,
      this.phone,
      this.avatar,
      this.theme});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    password = json['password'];
    email = json['email'];
    surname = json['surname'];
    family = json['family'];
    balance = json['balance'];
    year = json['year'];
    campus = json['campus'];
    phone = json['phone'];
    avatar = json['avatar'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['surname'] = this.surname;
    data['family'] = this.family;
    data['balance'] = this.balance;
    data['year'] = this.year;
    data['campus'] = this.campus;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['theme'] = this.theme;
    return data;
  }
}
