class ShopStatModel {
  int? id;
  String? name;
  int? totalSaleOfShop;
  TotalSaleAmountOfShop? totalSaleAmountOfShop;

  ShopStatModel({this.id, this.name, this.totalSaleOfShop, this.totalSaleAmountOfShop});

  ShopStatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalSaleOfShop = json['total_sale_of_shop'];
    totalSaleAmountOfShop = json['total_sale_amount_of_shop'] != null ? new TotalSaleAmountOfShop.fromJson(json['total_sale_amount_of_shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_sale_of_shop'] = this.totalSaleOfShop;
    if (this.totalSaleAmountOfShop != null) {
      data['total_sale_amount_of_shop'] = this.totalSaleAmountOfShop!.toJson();
    }
    return data;
  }
}

class TotalSaleAmountOfShop {
  double? priceSum;

  TotalSaleAmountOfShop({this.priceSum});

  TotalSaleAmountOfShop.fromJson(Map<String, dynamic> json) {
    priceSum = json['price__sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price__sum'] = this.priceSum;
    return data;
  }
}
