class ShopStatModel {
  int? id;
  String? shopName;
  int? quantity;
  TotalSaleAmountOfShop? totalSaleAmountOfShop;

  ShopStatModel({this.id, this.shopName, this.quantity, this.totalSaleAmountOfShop});

  ShopStatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['name'];
    quantity = json['total_sale_of_shop'];
    totalSaleAmountOfShop = json['total_sale_amount_of_shop'] != null ? new TotalSaleAmountOfShop.fromJson(json['total_sale_amount_of_shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.shopName;
    data['total_sale_of_shop'] = this.quantity;
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
