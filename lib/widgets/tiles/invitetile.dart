import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/screens/schedules/schedules_screen.dart';
import 'package:trocatalentos_app/services/proposal_api_service.dart';
import 'package:trocatalentos_app/services/schedule_api_service.dart';

class InviteTile extends StatefulWidget {
  final Proposal proposal;
  final bool isSended;

  InviteTile(this.proposal, this.isSended);

  @override
  _InviteTileState createState() => _InviteTileState();
}

class _InviteTileState extends State<InviteTile> {
  bool isLoadingDialog = false;
  FixedExtentScrollController _horaController;
  FixedExtentScrollController _minController;
  ProposalApiService apiProposal;
  ScheduleApiService apiSchedule;

  String stringDate;
  String stringHora;
  String stringMin;
  bool showPass;
  bool doneRequest = false;
  String responseMessage = '';
  DateTime dateProposal;
  String hourProposal = '';
  String minProposal = '';

  @override
  void initState() {
    apiProposal = ProposalApiService();
    apiSchedule = ScheduleApiService();
    dateProposal = DateTime.parse(widget.proposal.date);
    hourProposal = dateProposal.hour.toString();
    minProposal = dateProposal.minute.toString();
    print(hourProposal);
    print(minProposal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 110,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(0xFF3CC9A4),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return !widget.isSended  ? _dialogConfirmOrNot(
                      "Você recebeu uma solicitação de agendamento \nescolha uma data e hora para reagendar\nescolha recusar essa solicitação\nou confirmar para confirmar um agendamento"): _dialogCancelProposal(
                      "Você deseja cancelar a sua solicitação para\nTITULO DO TALENTO?");
                });
          },
          child: Column(
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
                  Text(
                    'Nome',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                !widget.isSended ? 'Ver detalhes' : 'Confirmar',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogConfirmOrNot(String messageContent) {
    return StatefulBuilder(
      builder: (context, setState){
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.87,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF2F9C7F),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
                  child: Text(
                    messageContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(
                  'Data',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: MediaQuery.of(context).size.width * 0.62,
                  height: 50,
                  decoration: BoxDecoration(
                    //color: Color.fromARGB(115, 223, 223, 223),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),),
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      initialDateTime: dateProposal,
                      minuteInterval: 1,
                      maximumYear: 2021,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime dateTime) {


                      },
                    ),
                  ),
                ),
                Text(
                  'Horário',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(115, 223, 223, 223),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: CupertinoPicker(
                        key: ValueKey('hora'),
                        scrollController: _horaController,
                        itemExtent: 30,
                        looping: true,
                        onSelectedItemChanged: (int x) {
                          stringHora = x.toString();
                        },
                        children: List.generate(
                          24,
                              (index) {
                            String text = index < 10 ? '0$index' : '$index';
                            return Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(text == '00' ? hourProposal.length < 2 ? '0$hourProposal' : '$hourProposal' : '$text',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)));
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.only(top: 20),
                      child: Text(":",
                          style:
                          TextStyle(fontFamily: 'Nunito', color: Colors.white)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(115, 223, 223, 223),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: CupertinoPicker(
                        key: ValueKey('min'),
                        scrollController: _minController,
                        itemExtent: 30,
                        looping: true,
                        onSelectedItemChanged: (int x) {
                          stringMin = x.toString();
                        },
                        children: List.generate(
                          4,
                              (index) {
                            int min = index * 15;
                            String text = min < 10 ? '0$min' : '$min';
                            return Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(text == '00' ? minProposal.length < 2 ? '0$minProposal' : '$minProposal' : '$text',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  color: Color(0xFF535252),
                  height: 1,
                ),
                !isLoadingDialog
                    ? doneRequest ? IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            'Recusar',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xFF535252),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoadingDialog = true;
                            print('Enviar');
                          });

                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 65,
                          height: 50,
                          child: Text(
                            'Reagendar',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xFF535252),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoadingDialog = true;
                            print('Enviar');
                          });
                          String response = await apiProposal.acceptProposal(widget.proposal.proposalId.toString());
                          setState(() {
                            isLoadingDialog = false;
                          });
                          if(response == '200') {
                            setState(()  {
                              responseMessage = 'Solicitação aceita com sucesso.';
                            });
                            await Future.delayed(Duration(seconds: 4));
                            doneRequest = false;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                          }else{
                            setState(()  {
                              responseMessage = 'Falha ao aceitar a solicitação.';
                            });
                            await Future.delayed(Duration(seconds: 4));
                            setState(()  {
                              responseMessage = 'Tente novamente';
                            });
                            await Future.delayed(Duration(seconds: 4));
                            setState(()  {
                              doneRequest = false;
                            });
                          }
                          /*if(response == '200'){
                            String responseSchedule = await apiSchedule.createSchedule(User.userId, widget.proposal.date);
                            print(responseSchedule);
                          }*/


                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 60,
                          height: 50,
                          child: Text(
                            'Confirmar',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 50,
                  child: Text(
                    responseMessage,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                )
                    : Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogCancelProposal(String messageContent) {
    return StatefulBuilder(
      builder: (context, setState){
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF2F9C7F),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
                  child: Text(
                    messageContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  color: Color(0xFF535252),
                  height: 1,
                ),
                !isLoadingDialog
                    ? doneRequest ? IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoadingDialog = true;
                            print('Enviar');
                          });

                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 200,
                          height: 50,
                          child: Text(
                            'Cancelar solicitação',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) :  Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: 50,
                  child: Text(
                    responseMessage,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                )
                    : Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
