class LydiaModel {
  String username;
  String password;
  String phoneNumber;
  String amount;

  LydiaModel({
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "phone_number": phoneNumber,
      "amount": amount,
    };
  }
}
