class ShopModel {
  int? id;
  String? name;
  String? description;
  String? color;
  String? image;

  ShopModel({
    this.id,
    this.name,
    this.description,
    this.color,
    this.image,
  });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['color'] = color;
    data['image'] = image;
    return data;
  }
}
