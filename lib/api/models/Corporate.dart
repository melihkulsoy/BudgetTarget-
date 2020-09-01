import 'package:butceappflutter/api/models/Shared.dart';

class Corporate extends Shared {
  final String name;
  final int userId;
  final int corporateTypeId;
  final String iconUrl;

  Corporate({id, createdDate, this.name, this.userId, this.corporateTypeId, this.iconUrl}) : super(id: id, createdDate: createdDate);

  factory Corporate.fromJson(Map<String, dynamic> json) {
    return Corporate(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      name: json['name'],
      userId: json['userId'],
      corporateTypeId: json['corporateTypeId'],
      iconUrl: json['iconUrl'],
    );
  }
}
