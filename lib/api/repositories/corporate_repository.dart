import 'dart:convert';

import 'package:butceappflutter/api/models/Corporate.dart';
import 'package:butceappflutter/api/repositories/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CorporateRepository extends BaseRepository {
  String repositoryUri;
  CorporateRepository() : super() {
    this.repositoryUri = '${super.baseUri}/Corporate';
  }

  Future<List<Corporate>> get() async {
    String requestUri = '${this.repositoryUri}';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    var corporatesJson = jsonDecode(response.body) as List;
    List<Corporate> corporates = corporatesJson.map((corporateJson) => Corporate.fromJson(corporateJson)).toList();
    return corporates;
  }
}