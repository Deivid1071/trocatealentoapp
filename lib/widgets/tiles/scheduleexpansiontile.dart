import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/services/schedule_api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';
import '../custom_alertdialog.dart';


class CustomExpansionTile extends StatefulWidget {
  final Schedule schedule;

  CustomExpansionTile(this.schedule);
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {

  bool isExpanded = false;
  String date;
  DateTime dateSchedule;
  String daySchedule = '';
  String monthSchedule = '';
  String hourSchedule = '';
  String minSchedule = '';
  TextEditingController _messageController = TextEditingController();
  bool doneRequest = false;
  String responseMessage = '';
  bool isLoadingDialog = false;
  ScheduleApiService api;

  @override
  void initState() {
    dateSchedule = DateTime.parse(widget.schedule.date);
    daySchedule = dateSchedule.day.toString();
    monthSchedule = dateSchedule.month.toString();
    hourSchedule = dateSchedule.hour.toString();
    minSchedule = dateSchedule.minute.toString();
    api = ScheduleApiService();
    super.initState();
  }

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
            "Agendamento em ${daySchedule.length < 2 ? '0$daySchedule' : '$daySchedule'}/${monthSchedule.length < 2 ? '0$monthSchedule' : '$monthSchedule'} - ${widget.schedule.talentName}",
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
                      margin: EdgeInsets.only(bottom: 5, top: 16),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 2)
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: widget.schedule.providerAvatar == null || widget.schedule.providerAvatar == '' ? Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                          ) : Image.network('${environment['baseUrl']}' +'/files/'+ widget.schedule.providerAvatar),),
                    ),
                    Text(widget.schedule.providerName ??'',
                        style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _dialogSendEmail();
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF37B895),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: Text('Contatar',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                            Icon(Icons.mail_sharp, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async {
                        String response = await api.deleteScheduleData(
                            widget.schedule.scheduleId);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                                messageContent: response == '200'
                                    ? 'Agendamento cancelado com sucesso.'
                                    : 'Falha ao cancelar o agendamento, por favor tente novamente');
                          },
                        ).then((value) =>
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                builder: (context) => HomeScreen())));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF37B895),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text('Cancelar agendamento',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 24,),
            Text(
              'Descrição do Talento',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Text(widget.schedule.description ?? '',
                  style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
            ),

          ],
          onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
        )
      ),
    );
  }



  _dialogSendEmail(){
    return StatefulBuilder(
      builder: (context, setState){
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF2F9C7F),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width:
                    MediaQuery.of(context).size.width *
                        0.85,
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();

                        },
                        controller: _messageController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              300),

                        ],
                        keyboardType: TextInputType.text,
                        //autofocus: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText:
                          'Escreva uma breve mensagem para ${widget.schedule.providerName}',
                          hintStyle: TextStyle(
                            fontFamily: 'Soleto',
                            fontSize: 14,
                            color: Colors.white
                                .withOpacity(0.19),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Divider(color: Colors.grey, height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: widget.schedule.emailToSendMessage,
                          query: 'subject=Mensagem Troca-Talentos&body=${_messageController.text}',
                        );
                        String url = params.toString();
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          print('Could not launch $url');
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        width: 60,
                        height: 50,
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
