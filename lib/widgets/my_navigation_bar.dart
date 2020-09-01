import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  onTabTapped(int index) {
    print(index);
    switch(index) {
      case 0: {
        if(ModalRoute.of(context).settings.name != '/homepage') {
          Navigator.pushReplacementNamed(context, '/homepage');
        }
      }
      break;
      case 1: {
        if(ModalRoute.of(context).settings.name != '/report') {
          Navigator.pushReplacementNamed(context, '/report');
        }
      }
      break;
      case 3: {
        if(ModalRoute.of(context).settings.name != '/profile') {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      }
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
      child: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer, color: Theme.of(context).accentColor),
            title: Text(
              'Harcamalarım',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).accentColor
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up, color: Theme.of(context).accentColor,),
            title: Text(
              'Rapor ve Tahmin',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).accentColor
              ),
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.timeline, color: Theme.of(context).accentColor,),
          //   title: Text(
          //     'Tahmin',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //       color: Theme.of(context).accentColor,
          //     ),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Theme.of(context).accentColor,),
            title: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
