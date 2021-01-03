import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/screens/configscreens/talentcreate_screen.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';

class MyTalentsScreen extends StatefulWidget {
  @override
  _MyTalentsScreenState createState() => _MyTalentsScreenState();
}

class _MyTalentsScreenState extends State<MyTalentsScreen> {
  bool isLoadingDialog = false;
  FixedExtentScrollController _horaController;
  FixedExtentScrollController _minController;

  String stringDate;
  String stringHora;
  String stringMin;
  bool showPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Meus Talentos',
      ).build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            /*showDialog(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return _dialogConfirmOrNot(
                      "Você recebeu uma solicitação de agendamento \nEscolha uma data e hora para reagendar,\nescolha recusar essa solicitação\nou confirmar para confirmar um agendamento");
                });*/
            /*showDialog(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return _dialogCancelProposal(
                      "Você deseja cancelar a sua solicitação para\nTITULO DO TALENTO?");
                });*/
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateTalentScreen()));
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color(0xFF2F9C7F),
          child: Text(
            'Criar um novo talento',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
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
