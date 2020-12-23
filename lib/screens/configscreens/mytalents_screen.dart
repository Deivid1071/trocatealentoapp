import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/screens/configscreens/talentcreate_screen.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';

class MyTalentsScreen extends StatefulWidget {
  @override
  _MyTalentsScreenState createState() => _MyTalentsScreenState();
}

class _MyTalentsScreenState extends State<MyTalentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Meus Talentos',
      ).build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateTalentScreen()));
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color(0xFF2F9C7F),
          child: Text(
            'Criar um novo talento',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
