// ignore_for_file: file_names

class Product {
  //! this is private fields add _ to set private
  late List<OldProductModel> _products;

  List<OldProductModel> get products => _products;

  Product({required totalSize, required typeId, required offset, required products}) {
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      _products = <OldProductModel>[];
      json['products'].forEach((v) {
        _products.add(OldProductModel.fromJson(v));
      });
    }
  }
}

class OldProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  OldProductModel({this.id, this.name, this.description, this.price, this.stars, this.img, this.location, this.createdAt, this.updatedAt, this.typeId});

  OldProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  //! allow to convert aProdudct to a Json String

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "location": location,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "type_id": typeId,
    };
  }
}
