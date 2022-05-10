class SaleListModel {
  int? id;
  String? datetime;
  int? sender;
  int? recipient;
  int? operator;
  int? moduleId;
  int? shop;
  List<int>? products;

  SaleListModel({this.id, this.datetime, this.sender, this.recipient, this.operator, this.moduleId, this.shop, this.products});

  SaleListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    sender = json['sender'];
    recipient = json['recipient'];
    operator = json['operator'];
    moduleId = json['module_id'];
    shop = json['shop'];
    products = json['products'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['datetime'] = datetime;
    data['sender'] = sender;
    data['recipient'] = recipient;
    data['operator'] = operator;
    data['module_id'] = moduleId;
    data['shop'] = shop;
    data['products'] = products;
    return data;
  }
}
