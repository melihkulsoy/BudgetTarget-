
import 'package:butceappflutter/api/models/User.dart';
import 'package:butceappflutter/api/repositories/user_repository.dart';
import 'package:butceappflutter/widgets/my_app_bar.dart';
import 'package:butceappflutter/widgets/my_navigation_bar.dart';
import 'package:butceappflutter/widgets/my_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  final userRepository = new UserRepository();
  getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    this.userRepository.me().then((user) {
      print(user.name);
      setState(() {
        this.user = user;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Profil',),
      body: (this.user != null) ? SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      //open edit profil
                    },
                    title: Text(
                      this.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
              const SizedBox(height: 10.0),
              // Card(
              //   elevation: 4.0,
              //   margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0)),
              //   child: Column(
              //     children: <Widget>[
              //       ListTile(
              //         leading: Icon(
              //           Icons.lock_outline,
              //           color: Theme.of(context).primaryColor,
              //         ),
              //         title: Text("Profili düzenle"),
              //         trailing: Icon(
              //           Icons.keyboard_arrow_right,
              //         ),
              //         onTap: () {},
              //       ),
              //       _buildDivider(),
              //       ListTile(
              //         leading: Icon(
              //           Icons.person,
              //           color: Theme.of(context).primaryColor,
              //         ),
              //         title: Text("Kişileri düzenle"),
              //         trailing: Icon(Icons.keyboard_arrow_right),
              //         onTap: () {
              //           Navigator.pushNamed(context, '/members/add');
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox( height: 10, ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    this.userRepository.logOut().then((value) {
                      if(value == true) {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    });
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor, ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          )) : MySpinKit(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
  Container _buildDivider(){
    return Container (
      margin:const EdgeInsets.symmetric(horizontal:8.0,),
      width: double.infinity,
      height:1.0,
      color: Colors.grey.shade400,
    );
  }
}
