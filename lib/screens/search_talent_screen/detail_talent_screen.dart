import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';

class DetailTalentScreen extends StatefulWidget {
  @override
  _DetailTalentScreenState createState() => _DetailTalentScreenState();
}

class _DetailTalentScreenState extends State<DetailTalentScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Visualizar Talento',).build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height*0.3,
                  width: width,
                  child: Image.network('https://as2.ftcdn.net/jpg/03/17/72/91/500_F_317729175_qLGD76QRMxcuxB34HWvf0cnlr34IqGpW.jpg', fit: BoxFit.fitWidth,),
                ),
                Positioned(
                  child: GestureDetector(
                    onTap: (){
                      print('open images');
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: height*0.3,
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Titulo do Talento",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 5.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 16),
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
              "Nome do Usuario",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F9C7F)),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Avaliações', style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: Color(0xFF2F9C7F)
                    ),),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFF2F9C7F),),
                        Icon(Icons.star_border, color: Color(0xFF2F9C7F),),
                        Icon(Icons.star_border, color: Color(0xFF2F9C7F),),
                        Icon(Icons.star_border, color: Color(0xFF2F9C7F),),
                        Icon(Icons.star_border, color: Color(0xFF2F9C7F),),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: Color(0xFF2F9C7F),size: 35,),
                    Text('5', style: TextStyle(
                        fontSize: 32.0,
                        color: Color(0xFF2F9C7F)),),
                  ],
                ),

              ],
            ),
            SizedBox(height: 24,),
            Text(
              "Descrição",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F9C7F)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                "Uma breve descrição sobre seu talento de forma a facilitar as pessoas entenderem ao ler",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 14.0,
                    color: Color(0xFF2F9C7F)),
              ),
            ),
            SizedBox(height: 24,),

          ],
        ),
      ),
    );
  }
}
