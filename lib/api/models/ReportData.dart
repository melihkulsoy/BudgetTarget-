class ReportData {
  ReportData({this.date, this.dateTime, this.value});
  final String date;
  final DateTime dateTime;
  final double value;

  factory ReportData.fromJson(dynamic json) {
    return ReportData(
      date: json['date'],
      dateTime: DateTime.parse(json['dateTime']),
      value: json['value'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'dateTime': dateTime.toString(),
      'value': value,
    };
  }
}
