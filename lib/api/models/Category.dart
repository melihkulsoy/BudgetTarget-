import 'Shared.dart';

class Category extends Shared {
  final String name;

  Category({id, DateTime createdDate, this.name})
      : super(id: id, createdDate: createdDate);
      
  factory Category.fromJson(dynamic json) {
    return Category(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"]);
  }
}
