import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MySpinKit extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
        color: Theme.of(context).primaryColor,
        size: 50
        );
  }
}