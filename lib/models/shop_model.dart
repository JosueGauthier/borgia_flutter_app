class Shop {
  late List<ShopModel> _shops;

  List<ShopModel> get shops => _shops;

  Shop({required shops}) {
    this._shops = shops;
  }

  Shop.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      _shops = <ShopModel>[];
      json['shops'].forEach((v) {
        _shops.add(ShopModel.fromJson(v));
      });
    }
  }
}

class ShopModel {
  int? id;
  String? name;
  String? description;
  String? color;

  ShopModel({this.id, this.name, this.description, this.color});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['color'] = this.color;
    return data;
  }
}
