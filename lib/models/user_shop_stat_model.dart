class UserShopStatModel {
  int? id;
  String? username;
  String? surname;
  double? balance;
  double? montantAchats;
  int? quantiteAchatsTotal;
  List<MontantMagasins>? montantMagasins;

  UserShopStatModel({this.id, this.username, this.surname, this.balance, this.montantAchats, this.quantiteAchatsTotal, this.montantMagasins});

  UserShopStatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    surname = json['surname'];
    balance = json['balance'];
    montantAchats = json['montant_achats'];
    quantiteAchatsTotal = json['qte_achats'];
    if (json['montant_magasins'] != null) {
      montantMagasins = <MontantMagasins>[];
      json['montant_magasins'].forEach((v) {
        montantMagasins!.add(MontantMagasins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['surname'] = surname;
    data['balance'] = balance;
    data['montant_achats'] = montantAchats;
    data['qte_achats'] = quantiteAchatsTotal;
    if (montantMagasins != null) {
      data['montant_magasins'] = montantMagasins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MontantMagasins {
  String? shopName;
  String? shopImage;
  int? quantity;
  double? montantAchats;

  MontantMagasins({this.shopName, this.shopImage, this.quantity, this.montantAchats});

  MontantMagasins.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    shopImage = json['shop_image'];
    quantity = json['qte_user_achats'];
    montantAchats = json['montant_achats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_name'] = shopName;
    data['shop_image'] = shopImage;
    data['qte_user_achats'] = quantity;
    data['montant_achats'] = montantAchats;
    return data;
  }
}
