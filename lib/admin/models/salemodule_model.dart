//! For selfsale module and operatorsale module
class SaleModuleModel {
  int? id;
  int? shop;

  SaleModuleModel({this.id, this.shop});

  SaleModuleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop = json['shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop'] = shop;
    return data;
  }
}
