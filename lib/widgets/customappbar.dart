import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/user.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actions: [
        Row(
          children: [
            Text(
              'Seu saldo',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16.0, color: Colors.white),
            ),
            SizedBox(width: 16,),
            Icon(
              Icons.monetization_on,
              color: Colors.white,
              size: 20,
            ),
            Text(
              User.tcoin.toString() ??'',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16.0, color: Colors.white),
            ),
            SizedBox(
              width: 24,
            )
          ],
        ),
      ],
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
