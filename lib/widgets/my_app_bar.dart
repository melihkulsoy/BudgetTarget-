import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
  final String title;
  MyAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      centerTitle: true,
    );
  }
}