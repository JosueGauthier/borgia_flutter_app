class ShopStatModel {
  int? id;
  String? shopImage;
  String? shopName;
  int? quantity;
  double? montantAchats;

  ShopStatModel({this.id, this.shopImage, this.shopName, this.quantity, this.montantAchats});

  ShopStatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopImage = json['image'];
    shopName = json['name'];
    quantity = json['total_sale_of_shop'];
    montantAchats = json['total_sale_amount_of_shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = shopImage;
    data['name'] = shopName;
    data['total_sale_of_shop'] = quantity;
    data['total_sale_amount_of_shop'] = montantAchats;
    return data;
  }
}
