class RankUserProductModel {
  int? id;
  String? name;
  String? image;
  List<ListOfProd>? listOfProd;

  RankUserProductModel({this.id, this.name, this.image, this.listOfProd});

  RankUserProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['list_of_prod'] != null) {
      listOfProd = <ListOfProd>[];
      json['list_of_prod'].forEach((v) {
        listOfProd!.add(ListOfProd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (listOfProd != null) {
      data['list_of_prod'] = listOfProd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListOfProd {
  int? id;
  String? name;
  String? image;
  List<UserTopTenProduct>? userTopTen;

  ListOfProd({this.id, this.name, this.image, this.userTopTen});

  ListOfProd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['user_top_ten'] != null) {
      userTopTen = <UserTopTenProduct>[];
      json['user_top_ten'].forEach((v) {
        userTopTen!.add(UserTopTenProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (userTopTen != null) {
      data['user_top_ten'] = userTopTen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTopTenProduct {
  int? id;
  String? username;
  String? surname;
  String? family;
  String? campus;
  int? promotion;
  double? montantAchatsParProduit;

  UserTopTenProduct({this.id, this.username, this.surname, this.family, this.campus, this.promotion, this.montantAchatsParProduit});

  UserTopTenProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    surname = json['surname'];
    family = json['family'];
    campus = json['campus'];
    promotion = json['promotion'];
    montantAchatsParProduit = json['montant_achats_par_produit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['surname'] = surname;
    data['family'] = family;
    data['campus'] = campus;
    data['promotion'] = promotion;
    data['montant_achats_par_produit'] = montantAchatsParProduit;
    return data;
  }
}
