class UserShopStatModel {
  int? id;
  String? username;
  String? surname;
  double? balance;
  double? montantAchats;
  int? qteAchats;
  List<MontantMagasins>? montantMagasins;

  UserShopStatModel({this.id, this.username, this.surname, this.balance, this.montantAchats, this.qteAchats, this.montantMagasins});

  UserShopStatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    surname = json['surname'];
    balance = json['balance'];
    montantAchats = json['montant_achats'];
    qteAchats = json['qte_achats'];
    if (json['montant_magasins'] != null) {
      montantMagasins = <MontantMagasins>[];
      json['montant_magasins'].forEach((v) {
        montantMagasins!.add(MontantMagasins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['surname'] = surname;
    data['balance'] = balance;
    data['montant_achats'] = montantAchats;
    data['qte_achats'] = qteAchats;
    if (montantMagasins != null) {
      data['montant_magasins'] = montantMagasins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MontantMagasins {
  String? shopName;
  String? shopImage;
  int? qteUserAchats;

  MontantMagasins({this.shopName, this.shopImage, this.qteUserAchats});

  MontantMagasins.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    shopImage = json['shop_image'];
    qteUserAchats = json['qte_user_achats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['shop_name'] = shopName;
    data['shop_image'] = shopImage;
    data['qte_user_achats'] = qteUserAchats;
    return data;
  }
}
