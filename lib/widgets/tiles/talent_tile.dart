import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TalentTile extends StatefulWidget {
  @override
  _TalentTileState createState() => _TalentTileState();
}

class _TalentTileState extends State<TalentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.38,
      width: MediaQuery.of(context).size.width*0.7,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(0xFF3CC9A4),
        child: InkWell(
          onTap: (){
            print('Clicked');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(

                            margin: EdgeInsets.only(bottom: 10),
                            height: 85,
                            width: 85,
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
                      Column(
                        children: [
                          Text('Titulo do Talento', style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 30,
                          ),
                          Text('Tcoin: 3', style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),)
                        ],
                      )
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text('Descrição simples  sobre o talição simples  sobre o talento Descrição simples  sobre o talento', style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
