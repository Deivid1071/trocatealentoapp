import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/widgets/tiles/configtile.dart';

import 'config_perfil_screen.dart';
import 'mytalents_screen.dart';

class UserConfigScreen extends StatefulWidget {
  @override
  _UserConfigScreenState createState() => _UserConfigScreenState();
}

class _UserConfigScreenState extends State<UserConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3CC9A4),
                    Color(0xFF37B895),
                    Color(0xFF32A687),
                    Color(0xFF2F9C7F),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 110,
                            width: 110,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/avatar.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Text(
                            "User name",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                    ),
                    ConfigTile(
                      icon: Icons.person,
                      text: 'Dados pessoais',
                      page: PerfilConfigScreen(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ConfigTile(
                      icon: Icons.title,
                      text: 'Meus Talentos',
                      page: MyTalentsScreen(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ConfigTile(
                      icon: Icons.library_books,
                      text: 'Termos e condições',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ConfigTile(
                      icon: Icons.featured_play_list,
                      text: 'Politicas e Privacidade',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
