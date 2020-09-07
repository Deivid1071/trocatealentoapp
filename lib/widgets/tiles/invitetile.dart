
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InviteTile extends StatefulWidget {
  @override
  _InviteTileState createState() => _InviteTileState();
}

class _InviteTileState extends State<InviteTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 110,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(0xFF3CC9A4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 55,
                  width: 55,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      )),
                ),
                Text('Nome', style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
            Text('Aceitar', style: TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
