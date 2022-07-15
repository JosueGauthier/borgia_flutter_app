class DeleteProductModel {
  String username;
  String password;
  int productId;

  DeleteProductModel({
    required this.username,
    required this.password,
    required this.productId,

  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "product_id": productId,

    };
  }
}
