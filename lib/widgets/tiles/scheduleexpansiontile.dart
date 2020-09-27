import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/schedule.dart';

class CustomExpansionTile extends StatefulWidget {
  final Schedule schedule;

  CustomExpansionTile(this.schedule);
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(      
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF3CC9A4),
          borderRadius: BorderRadius.circular(16)
        ),
        child: ExpansionTile(
          title: Text(
            "Agendamento em ${widget.schedule.date}",
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
          leading: Icon(
            Icons.calendar_today,
            size: 36.0,
            color: Colors.white,
          ),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 55,
                      width: 55,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text('Nome1', style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 55,
                      width: 55,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text('Nome2', style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ],
            ),
            Text('Descrição breve sobre o angedamento', style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
            Text('Observação ou lembrete breve sobre agendamento', style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nunito',
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          ],
          onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
        )
      ),
    );
  }
}
