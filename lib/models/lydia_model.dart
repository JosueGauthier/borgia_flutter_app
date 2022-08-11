class LydiaModelDoRequestModel {
  String username;
  String password;
  String phoneNumber;
  String amount;

  LydiaModelDoRequestModel({
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

class LydiaModelStateRequestModel {
  String username;
  String password;
  String requestUuid;

  LydiaModelStateRequestModel({required this.username, required this.password, required this.requestUuid});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "request_uuid": requestUuid,
    };
  }
}
