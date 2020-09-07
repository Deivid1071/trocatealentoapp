import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Color(0xFF3CC9A4),
      elevation: 0,
      title: Text(title, style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 24,
          color: Colors.white
      ),),
    );
  }
}
