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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["username"] = this.name;
    data["password"] = this.password;
    data["email"] = this.email;
    data["phone"] = this.phone;

    return data;
  }
}
