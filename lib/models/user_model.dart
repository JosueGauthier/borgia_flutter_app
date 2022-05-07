class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? firstName;
  String? password;
  String? email;
  String? surname;
  String? family;
  String? balance;
  int? year;
  String? campus;
  String? phone;
  String? avatar;
  String? theme;
  String? image;

  UserModel(
      {this.id,
      this.name,
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
      this.image,
      this.theme});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['username'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = name;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['password'] = password;
    data['email'] = email;
    data['surname'] = surname;
    data['family'] = family;
    data['balance'] = balance;
    data['year'] = year;
    data['campus'] = campus;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['theme'] = theme;
    return data;
  }
}
