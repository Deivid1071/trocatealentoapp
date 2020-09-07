import 'package:flutter/material.dart';
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
          appBar: CustomAppBar(title: 'Trocar Talentos',).build(context),
          drawer: CustomDrawer(_pageController),
          body: Container(color: Colors.deepPurple,),
        ),
        Scaffold(
          appBar: CustomAppBar(title: 'Agendamentos',).build(context),
          body: Container(color: Colors.amber,),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: CustomAppBar(title: 'Configurações',).build(context),
          body: Container(color: Colors.red,),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
