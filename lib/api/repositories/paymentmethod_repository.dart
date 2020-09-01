import 'dart:convert';

import 'package:butceappflutter/api/models/PaymentMethod.dart';
import 'package:butceappflutter/api/repositories/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentMethodRepository extends BaseRepository {
  String repositoryUri;
  PaymentMethodRepository() : super() {
    this.repositoryUri = '${super.baseUri}/PaymentMethod';
  }
  Future<List<PaymentMethod>> get() async {
    String requestUri = '${this.repositoryUri}';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    var paymentMethodsJson = jsonDecode(response.body) as List;
    List<PaymentMethod> paymentMethods = paymentMethodsJson.map((paymentMethodJson) => PaymentMethod.fromJson(paymentMethodJson)).toList();
    return paymentMethods;
  }
}