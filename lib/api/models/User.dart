import 'Shared.dart';

class User extends Shared {
  final String name;
  final String mailAddress;
  final String hashedPassword;

  User({id, DateTime createdDate, this.name, this.mailAddress, this.hashedPassword})
    : super(id: id, createdDate: createdDate);

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      name: json['name'] as String,
      mailAddress: json['mailAddress'],
      hashedPassword: json['hashedPassword'],
    );
  }
}