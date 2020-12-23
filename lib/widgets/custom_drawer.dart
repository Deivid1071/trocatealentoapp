import 'package:flutter/material.dart';

import 'package:trocatalentos_app/widgets/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
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
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 280.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Troca \nTalentos",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        top: 110,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Olá, Usuario",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 50,
              ),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(
                  Icons.calendar_today, "Agendamentos", pageController, 1),
              DrawerTile(Icons.settings, "Configurações", pageController, 2),
            ],
          )
        ],
      ),
    );
  }
}
