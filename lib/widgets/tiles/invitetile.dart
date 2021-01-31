import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/proposal.dart';
import 'package:trocatalentos_app/model/schedule.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/screens/schedules/schedules_screen.dart';
import 'package:trocatalentos_app/services/proposal_api_service.dart';
import 'package:trocatalentos_app/services/schedule_api_service.dart';

import '../../config.dart';

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
  int hourProposalInt = 0;
  String minProposal = '';
  int compareDate;

  @override
  void initState() {
    apiProposal = ProposalApiService();
    apiSchedule = ScheduleApiService();
    dateProposal = DateTime.parse(widget.proposal.date);
    hourProposalInt = dateProposal.hour;
    hourProposal = (hourProposalInt - 3).toString();
    minProposal = dateProposal.minute.toString();
    print(hourProposal);
    print(minProposal);
    compareDate = DateTime.now().compareTo(dateProposal);
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
          onTap: widget.proposal.accepted == "Y" ? null : () {
            showDialog(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return !widget.isSended
                      ? _dialogConfirmOrNot(
                          "Você recebeu uma solicitação de agendamento \nescolha recusar essa solicitação\nou confirmar para confirmar um agendamento")
                      : _dialogCancelProposal(
                          "Você deseja cancelar a sua solicitação ?");
                }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())));
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: !widget.isSended  ? widget.proposal.contractorAvatar == null ||
                          widget.proposal.contractorAvatar == ''
                          ? Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      )
                          : Image.network('${environment['baseUrl']}' +
                          '/files/' +
                          widget.proposal.contractorAvatar) : widget.proposal.providerAvatar == null ||
                          widget.proposal.providerAvatar == ''
                          ? Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      )
                          : Image.network('${environment['baseUrl']}' +
                          '/files/' +
                          widget.proposal.providerAvatar),
                    ),
                  ),
                  Text(
                    !widget.isSended ?  widget.proposal.contractorName ?? '' : widget.proposal.providerName ?? '' ,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                !widget.isSended ? widget.proposal.accepted == "Y" ? 'Aceita' : 'Ver detalhes' : 'Cancelar',
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
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                  margin:
                      EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
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
                        dateTimePickerTextStyle:
                            TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      minimumDate:
                          compareDate != (-1) ? dateProposal : DateTime.now(),
                      initialDateTime: dateProposal,
                      maximumDate: dateProposal,
                      minuteInterval: 1,
                      maximumYear: 2021,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime dateTime) {},
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
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                              hourProposal.length < 2
                                  ? '0$hourProposal'
                                  : '$hourProposal',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.only(top: 20),
                      child: Text(":",
                          style: TextStyle(
                              fontFamily: 'Nunito', color: Colors.white)),
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
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                              minProposal.length < 2
                                  ? '0$minProposal'
                                  : '$minProposal',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
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
                    ? !doneRequest
                        ? IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoadingDialog = true;
                                      print('Enviar');
                                    });
                                    String response =
                                        await apiProposal.acceptProposal(
                                            widget.proposal.proposalId
                                                .toString(),
                                            'N');
                                    setState(() {
                                      isLoadingDialog = false;
                                      doneRequest = true;
                                    });
                                    if (response == '200') {
                                      setState(() {
                                        responseMessage =
                                            'Solicitação recusada com sucesso.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      doneRequest = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      setState(() {
                                        responseMessage =
                                            'Falha ao recusar a solicitação.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        responseMessage = 'Tente novamente';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        doneRequest = false;
                                      });
                                    }
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
                                /*VerticalDivider(
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
                      ),*/
                                VerticalDivider(
                                  color: Color(0xFF535252),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoadingDialog = true;
                                      print('Enviar');
                                    });
                                    String response =
                                        await apiProposal.acceptProposal(
                                            widget.proposal.proposalId
                                                .toString(),
                                            'Y');
                                    setState(() {
                                      isLoadingDialog = false;
                                      doneRequest = true;
                                    });
                                    if (response == '200') {
                                      setState(() {
                                        responseMessage =
                                            'Solicitação aceita com sucesso.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      doneRequest = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      setState(() {
                                        responseMessage =
                                            'Falha ao aceitar a solicitação.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        responseMessage = 'Tente novamente';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        doneRequest = false;
                                      });
                                    }
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
                          )
                        : Container(
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
                          ),
                        ),
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
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                  margin:
                      EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
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
                    ? !doneRequest
                        ? IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoadingDialog = true;
                                    });
                                    String response =
                                        await apiProposal.acceptProposal(
                                            widget.proposal.proposalId
                                                .toString(),
                                            'N');
                                    setState(() {
                                      isLoadingDialog = false;
                                      doneRequest = true;
                                    });
                                    if (response == '200') {
                                      setState(() {
                                        responseMessage =
                                            'Solicitação recusada com sucesso.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      doneRequest = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      setState(() {
                                        responseMessage =
                                            'Falha ao recusar a solicitação.';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        responseMessage = 'Tente novamente';
                                      });
                                      await Future.delayed(
                                          Duration(seconds: 4));
                                      setState(() {
                                        doneRequest = false;
                                      });
                                    }
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
                          )
                        : Container(
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
