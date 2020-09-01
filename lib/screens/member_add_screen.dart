import 'package:butceappflutter/main.dart';
import 'package:butceappflutter/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class MemberAddScreen extends StatefulWidget {
  @override
  _MemberAddScreenState createState() => _MemberAddScreenState();
}

class _MemberAddScreenState extends State<MemberAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Kişileri Düzenle',),
    );
  }
}
