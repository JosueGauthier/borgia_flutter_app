// ignore_for_file: unnecessary_new

class SearchModel {
  String? name;

  SearchModel({
    this.name,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  SearchModel.fromJsonPlusMainId(Map<String, dynamic> json, int mainId) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;

    return data;
  }
}
