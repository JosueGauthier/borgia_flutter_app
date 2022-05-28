class RankUserShopModel {
  int? id;
  String? name;
  String? image;
  List<UserTopTen>? userTopTen;

  RankUserShopModel({this.id, this.name, this.image, this.userTopTen});

  RankUserShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['user_top_ten'] != null) {
      userTopTen = <UserTopTen>[];
      json['user_top_ten'].forEach((v) {
        userTopTen!.add(UserTopTen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (userTopTen != null) {
      data['user_top_ten'] = userTopTen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTopTen {
  int? id;
  String? username;
  String? surname;
  String? family;
  String? campus;
  int? promotion;
  double? montantAchatsParShop;

  UserTopTen({this.id, this.username, this.surname, this.family, this.campus, this.promotion, this.montantAchatsParShop});

  UserTopTen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    surname = json['surname'];
    family = json['family'];
    campus = json['campus'];
    promotion = json['promotion'];
    montantAchatsParShop = json['montant_achats_par_shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['surname'] = surname;
    data['family'] = family;
    data['campus'] = campus;
    data['promotion'] = promotion;
    data['montant_achats_par_shop'] = montantAchatsParShop;
    return data;
  }
}
