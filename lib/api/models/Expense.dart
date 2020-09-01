import 'Shared.dart';

class Expense extends Shared {
  final String name;
  final double amount;
  final String description;
  final String city;
  final DateTime date;
  final String corporateId;
  final String memberId;
  final String userId;

  Expense(
      {
        String id,
        DateTime createdDate,
        this.name,
        this.amount,
        this.description,
        this.city,
        this.date,
        this.corporateId,
        this.memberId,
        this.userId
        }) : super(id: id, createdDate: createdDate);

  factory Expense.fromJson(dynamic json) {
    return Expense(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      name: json['name'],
      description: json['description'],
      amount: json['amount'],
      city: json['city'],
      date: DateTime.parse(json['date']),
      corporateId: json['corporateId'],
      memberId: json['memberId'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdDate': createdDate.toString(),
      'name': name,
      'description': description,
      'amount': amount,
      'city': city,
      'date': date.toString(),
      'corporateId': corporateId,
      'memberId': memberId,
      'userId': userId,
    };
  }
}
