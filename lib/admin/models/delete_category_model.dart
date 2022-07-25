class DeleteCategoryModel {
  String username;
  String password;
  int categoryId;

  DeleteCategoryModel({
    required this.username,
    required this.password,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "category_id": categoryId,
    };
  }
}
