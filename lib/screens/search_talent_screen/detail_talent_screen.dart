import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trocatalentos_app/model/talent.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'dart:convert';
import 'package:trocatalentos_app/services/proposal_api_service.dart';
import 'package:trocatalentos_app/services/talent_api_service.dart';
import 'package:trocatalentos_app/widgets/custom_alertdialog.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';

import '../../config.dart';

class DetailTalentScreen extends StatefulWidget {
  final int talentId;

  DetailTalentScreen({this.talentId});

  @override
  _DetailTalentScreenState createState() => _DetailTalentScreenState();
}

class _DetailTalentScreenState extends State<DetailTalentScreen> {
  bool isLoadingDialog = false;
  FixedExtentScrollController _horaController;
  FixedExtentScrollController _minController;
  TalentApiService apiTalent;
  ProposalApiService apiProposal;
  Talent talent;

  DateTime _dateTime;
  String stringDate;
  String stringHora;
  String stringMin;
  bool showPass;
  bool isLoading = true;

  @override
  void initState() {
    apiTalent = TalentApiService();
    apiProposal = ProposalApiService();
    stringHora = '00';
    stringMin = '00';
    _dateTime = DateTime.now();
    getTalentData();
    super.initState();
  }

  getTalentData() async {
    TalentResponse talentResponse =
        await apiTalent.getTalentById(widget.talentId.toString());
    setState(() {
      isLoading = false;
    });
    if (talentResponse.resultDetailTalent.talentId != null ||
        talentResponse.resultDetailTalent.talentId != '') {
      setState(() {
        talent = talentResponse.resultDetailTalent;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              messageContent:
                  'Erro ao carregar detalhes do talento, por favor tente novamente.');
        },
      ).then((value) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Visualizar Talento',
        ).build(context),
        body: !isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width,
                          color: Colors.grey[200],
                          child: talent.banner != null && talent.banner != ''
                              ? Image.network(
                                  '${environment['baseUrl']}' +'/files/'+ talent.banner, fit: BoxFit.cover)
                              : Container(),
                        ),
                        Positioned(
                          child: GestureDetector(
                            onTap: null,
                            child: Container(
                              color: Colors.transparent,
                              height: height * 0.3,
                              width: width,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    talent.talentTitle ?? "Titulo do Talento",
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xFF2F9C7F), width: 2)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: talent.avatar == null || talent.avatar == ''
                            ? Image.asset(
                                'assets/images/avatar.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network('${environment['baseUrl']}' +
                                '/files/' +
                            talent.avatar),
                      ),
                    ),
                    Text(
                      talent.userName??"Nome do Usuario",
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F9C7F)),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Avaliações',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  color: Color(0xFF2F9C7F)),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xFF2F9C7F),
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF2F9C7F),
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF2F9C7F),
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF2F9C7F),
                                ),
                                Icon(
                                  Icons.star_border,
                                  color: Color(0xFF2F9C7F),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Color(0xFF2F9C7F),
                              size: 35,
                            ),
                            Text(
                              talent.tcoin.toString() ??'5',
                              style: TextStyle(
                                  fontSize: 32.0, color: Color(0xFF2F9C7F)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Descrição",
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F9C7F)),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text(
                        talent.descricao??"",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14.0,
                            color: Color(0xFF2F9C7F)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF2F9C7F)),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !isLoading
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (BuildContext context) {
                          return _dialogSchedule(
                              "Selecione a data que gostaria de agendar \n Titulo do Talento");
                        });
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF2F9C7F),
                  child: Text(
                    'Solicitar um agendamento',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              )
            : Container());
  }

  Widget _dialogSchedule(String messageContent) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                      minimumDate: DateTime.now(),
                      minuteInterval: 1,
                      maximumYear: 2021,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime dateTime) {
                        setState(() {
                          _dateTime = dateTime;
                          stringDate =
                              DateFormat("dd-MM-yyyy").format(dateTime);
                        });
                        print(stringDate);
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
                                child: Text('$text',
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
                      child: CupertinoPicker(
                        key: ValueKey('min'),
                        scrollController: _minController,
                        itemExtent: 30,
                        looping: true,
                        onSelectedItemChanged: (int x) {
                          x = x * 15;
                          stringMin = x.toString();
                        },
                        children: List.generate(
                          4,
                          (index) {
                            int min = index * 15;
                            String text = min < 10 ? '0$min' : '$min';
                            return Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Text('$text',
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
                    ? IntrinsicHeight(
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
                                  'Cancelar',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 15,
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
                                });

                                String dateWithoutHour = stringDate =
                                    DateFormat("yyyy-MM-dd").format(_dateTime);

                                String date = dateWithoutHour +
                                    ' ' +
                                    (stringHora.length <= 1
                                        ? '0$stringHora'
                                        : stringHora) +
                                    ':' +
                                    (stringMin.length <= 1
                                        ? '0$stringMin'
                                        : stringMin) +
                                    ':' +
                                    '00';
                                String response = await apiProposal
                                    .createProposal(User.userId, date, 5);
                                print(response);
                                setState(() {
                                  isLoadingDialog = false;
                                });
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
