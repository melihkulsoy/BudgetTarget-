import 'Shared.dart';

class PaymentMethod extends Shared {
  final String name;
  final String description;

  PaymentMethod({id, DateTime createdDate, this.name, this.description}) : super(id: id, createdDate: createdDate);

  factory PaymentMethod.fromJson(dynamic json) {
    return PaymentMethod(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      name: json['name'],
      description: json['description'],
    );
  }
}
