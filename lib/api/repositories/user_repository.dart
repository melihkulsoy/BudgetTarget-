import 'dart:convert';
import 'package:butceappflutter/api/models/User.dart';
import 'package:butceappflutter/api/repositories/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class UserRepository extends BaseRepository {
  String repositoryUri;
  UserRepository() : super() {
    this.repositoryUri = '${super.baseUri}/User';
  }

  Future<http.Response> signUp(String email, String name, String password) async {
    String requestUri = '${this.repositoryUri}/Signup';
    Map data = {
      'email': email,
      'name': name,
      'password': password
    };
    //encode Map to JSON
    var body = json.encode(data);
    print(body);
    final response = await http.post(requestUri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    User user = User.fromJson(jsonDecode(response.body));
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString('hashedKey', user.hashedPassword);
    myPrefs.setString('userId', user.id);
    myPrefs.setString('username', user.name);
    myPrefs.setString('userMail', user.mailAddress);
    return response;
  }

  Future<http.Response> logIn(String email, String password) async {
    String requestUri = '${this.repositoryUri}/Login';
    Map data = {
      'email': email,
      'password': password
    };
    var body = json.encode(data);
    print(body);
    var response = await http.post(requestUri,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    print(response.request);
    print(response.body);
    print(response.statusCode);
    User user = User.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200) {
      myPrefs.setString('hashedKey', user.hashedPassword);
      myPrefs.setString('userId', user.id);
      myPrefs.setString('username', user.name);
      myPrefs.setString('userMail', user.mailAddress);
    }
    return response;
  }
  Future<User> me() async {
    String requestUri = '${this.repositoryUri}/Me';
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var response = await http.get(
      requestUri,
      headers: {
        "Content-Type": "application/json",
        "Key": myPrefs.get('hashedKey')
      },
    );
    User user = User.fromJson(jsonDecode(response.body));
    return user;
  }
  Future<bool> logOut() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.remove('hashedKey');
    return true;
  }
}