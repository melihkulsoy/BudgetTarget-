import 'dart:convert';

import 'package:butceappflutter/api/models/Category.dart';
import 'package:butceappflutter/api/repositories/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends BaseRepository {
  String repositoryUri;
  CategoryRepository() : super() {
    this.repositoryUri = '${super.baseUri}/Category';
  }

  Future<List<Category>> get() async {
    String requestUri = '${this.repositoryUri}';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    var categoriesJson = jsonDecode(response.body) as List;
    List<Category> expenses = categoriesJson.map((expenseJson) => Category.fromJson(expenseJson)).toList();
    return expenses;
  }
}