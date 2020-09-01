import 'dart:convert';

import 'package:butceappflutter/api/models/Expense.dart';
import 'package:butceappflutter/api/models/ReportData.dart';
import 'package:butceappflutter/api/repositories/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseRepository extends BaseRepository {
  String repositoryUri;
  ExpenseRepository() : super() {
    this.repositoryUri = '${super.baseUri}/Expense';
  }
  Future<List<Expense>> get() async {
    String requestUri = '${this.repositoryUri}';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    var expensesJson = jsonDecode(response.body) as List;
    List<Expense> expenses = expensesJson.map((expenseJson) => Expense.fromJson(expenseJson)).toList();
    return expenses;
  }
  Future<List<ReportData>> getReportData({String reportType, DateTime startDate, DateTime endDate}) async {
    String requestUri = '';
    if(reportType == 'Günlük') requestUri = '${this.repositoryUri}/Report/Daily';
    else if(reportType == 'Haftalık') requestUri = '${this.repositoryUri}/Report/Weekly';
    else if(reportType == 'Aylık') requestUri = '${this.repositoryUri}/Report/Monthly';
    if(startDate != null && endDate != null) {
      requestUri += '?startDate=$startDate&endDate=$endDate';
    }
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      }
    );
    var reportsJson = jsonDecode(response.body) as List;
    List<ReportData> reportData = reportsJson.map((reportJson) => ReportData.fromJson(reportJson)).toList();
    return reportData;
  }
  Future<List<ReportData>> forecast({List<ReportData> expenses, String first, String second}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    String firstParam = "";
    String secondParam = "";
    if(first == 'Günlük') firstParam = 'Day';
    else if(first == 'Haftalık') firstParam = 'Week';
    else if(first == 'Aylık') firstParam = 'Month';
    if(second == 'Haftalık') secondParam = 'Week';
    else if(second == 'Aylık') secondParam = 'Month';
    String requestUri = '${this.repositoryUri}/Forecast/${firstParam}To$secondParam';
    // if(firstParam == 'Day' && secondParam == 'Week')
    var body = jsonEncode(expenses.map((e) => e.toMap()).toList());
    print(body);
    var response = await http.post(
      requestUri,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      }
    ).catchError((error) {
      print(error);
    });
    var reportsJson = jsonDecode(response.body) as List;
    List<ReportData> reportData = reportsJson.map((reportJson) => ReportData.fromJson(reportJson)).toList();
    print(response.statusCode);
    print(response.body);
    return reportData;
  }
  Future<http.Response> post(Expense expense) async {
    String requestUri = '${this.repositoryUri}';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var body = json.encode(expense.toMap());
    print(body);
    var response = await http.post(
      requestUri,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
  Future<http.Response> delete(String id) async {
    String requestUri = '${this.repositoryUri}/$id';
    print(requestUri);
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.delete(
      requestUri,
      headers: {
        "Key": myPrefs.get('hashedKey')
      },
    );
    return response;
  }
}