import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/screens/home/login_screen.dart';
import 'package:trocatalentos_app/widgets/tiles/configtile.dart';

import '../../config.dart';
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white, width: 2)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: User.image == null || User.image == '' ? Image.asset(
                                    'assets/images/avatar.png',
                                    fit: BoxFit.cover,
                                  ) : Image.network('${environment['baseUrl']}' +'/files/'+ User.image),),),
                          ),
                          Text(
                            User.name ?? "User name",
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
                    SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: (){
                        User.userId = null;
                        User.image = null;
                        User.name = null;
                        User.email = null;
                        User.tcoin = null;
                        User.token = null;
                        User.haveNotifications = false;
                        User.lastSchedulefinished = null;
                        User.qtsNewProposals = null;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Sair',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
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
