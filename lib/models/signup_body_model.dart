// ignore_for_file: unnecessary_new

class SignUpBodyModel {
  String name;
  String phone;
  String email;
  String password;

  SignUpBodyModel({required this.name, required this.email, required this.password, required this.phone});

  @override
  String toString() {
    return name.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["username"] = name;
    data["password"] = password;
    data["email"] = email;
    data["phone"] = phone;

    return data;
  }
}
