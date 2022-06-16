class RankUserModel {
  String? username;
  double? montantAchats;
  int? index;

  RankUserModel({this.username, this.montantAchats, this.index});

  RankUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    montantAchats = json['montant_achats'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['montant_achats'] = montantAchats;
    data['index'] = index;
    return data;
  }
}
