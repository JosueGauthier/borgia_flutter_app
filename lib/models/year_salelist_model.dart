class YearChartModel {
  String? startDay;
  double? priceSum;

  YearChartModel({this.startDay, this.priceSum});

  YearChartModel.fromJson(Map<String, dynamic> json) {
    startDay = json['start_day'];
    priceSum = json['price_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_day'] = this.startDay;
    data['price_sum'] = this.priceSum;
    return data;
  }
}
