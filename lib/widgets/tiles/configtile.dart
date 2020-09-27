

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/utilities/constants.dart';

class ConfigTile extends StatelessWidget {
  final IconData  icon;
  final String text;

  const ConfigTile({Key key, this.icon, this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: kBoxDecorationStyle,
      child: ListTile(
        leading: Icon(icon, color: Colors.white,),
        title: Text(text, style: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('App em Desenvolvimento'),
                content: Text('Futuramente aqui você verá  detalhes sobre $text'),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
