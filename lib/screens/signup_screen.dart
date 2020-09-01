import 'package:butceappflutter/api/repositories/user_repository.dart';
import 'package:butceappflutter/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool loading = false;
  final userRepository = new UserRepository();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Butce App'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              Dialogs.showLoadingDialog(context, _keyLoader);
                              this.userRepository.signUp(
                                  this.emailController.text,
                                  this.nameController.text,
                                  this.passwordController.text
                              ).then((response) {
                                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                                if(response.statusCode == 200) {
                                  Navigator.pushReplacementNamed(context, "/homepage");
                                }
                              });
                            }
                          },
                          child: Text(
                            'Submit',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}