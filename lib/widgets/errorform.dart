import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorForm extends StatelessWidget {
  final String msg;

  const ErrorForm({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      child: Text(
        msg,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.white,
            fontSize: 10
        ),
      ),
    );
  }
}
