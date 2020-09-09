import 'package:flutter/material.dart';
import 'package:trocatalentos_app/screens/configscreens/config_screen.dart';
import 'package:trocatalentos_app/screens/schedules/schedules_screen.dart';
import 'package:trocatalentos_app/widgets/custom_drawer.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: CustomAppBar(title: 'Inicio',).build(context),
          body: Container(color: Colors.purple,),
          drawer: CustomDrawer(_pageController),

        ),
        Scaffold(
          appBar: CustomAppBar(title: 'Agendamentos',).build(context),
          body: SchedulesScreen(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: CustomAppBar(title: 'Configurações',).build(context),
          body: UserConfigScreen(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
