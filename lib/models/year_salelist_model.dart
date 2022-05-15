class YearChartModel {
  String? startDay;
  double? priceSum;

  YearChartModel({this.startDay, this.priceSum});

  YearChartModel.fromJson(Map<String, dynamic> json) {
    startDay = json['start_day'];
    priceSum = json['price_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_day'] = startDay;
    data['price_sum'] = priceSum;
    return data;
  }
}
