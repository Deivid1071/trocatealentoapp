import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/talent.dart';
import 'package:trocatalentos_app/screens/configscreens/talentcreate_screen.dart';
import 'package:trocatalentos_app/screens/search_talent_screen/detail_talent_screen.dart';

import '../../config.dart';

class TalentTile extends StatefulWidget {
  final Talent talent;
  final bool myTalent;

  TalentTile(this.talent, {this.myTalent});

  @override
  _TalentTileState createState() => _TalentTileState();
}

class _TalentTileState extends State<TalentTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(0xFF3CC9A4),
        child: InkWell(
          onTap: () {
            if(widget.myTalent != null){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateTalentScreen(talent: widget.talent)));
            }else{
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailTalentScreen(talentId: widget.talent.talentId)));
            }
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white, width: 2)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: widget.talent.avatar == null || widget.talent.avatar == '' ? Image.asset(
                                  'assets/images/avatar.png',
                                  fit: BoxFit.cover,
                                ) : Image.network('${environment['baseUrl']}' +'/files/'+ widget.talent.avatar),),
                          ),
                          Text(
                            widget.talent.userName??"",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text(
                                widget.talent.talentTitle,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Custo: ${widget.talent.tcoin} Tcoin's" ,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
              /*SizedBox(
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
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
