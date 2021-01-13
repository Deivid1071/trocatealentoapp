import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/services/notification_api_service.dart';
import 'package:trocatalentos_app/services/notification_api_service.dart';

class NotificationAlertDialog extends StatefulWidget {
  final String messageContent;

  NotificationAlertDialog({this.messageContent});
  @override
  _NotificationAlertDialogState createState() => _NotificationAlertDialogState();
}

class _NotificationAlertDialogState extends State<NotificationAlertDialog> {

  int ratingValue = 0;
  bool doneRequest = false;
  String responseMessage = '';
  bool isLoadingDialog = false;
  NotificationApiService apiNotification = NotificationApiService();


  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
                  child: Text(
                    'Você possui ${User.qtsNewProposals} novas solicitações \nPor favor verifique em Agendamentos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 16),
                  child: Text(
                    'Como você avalia o talento: \nNome do talento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(
                      ratingValue >= 1 ? Icons.star : Icons.star_border,
                      size: 35,
                      color: Colors.white,
                    ), onPressed: (){
                      setState(() {
                        ratingValue = 1;
                      });
                    }),
                    IconButton(icon: Icon(
                      ratingValue >= 2 ? Icons.star : Icons.star_border,
                      size: 35,
                      color: Colors.white,
                    ), onPressed: (){
                      setState(() {
                        ratingValue = 2;
                      });
                    }),
                    IconButton(icon: Icon(
                      ratingValue >= 3 ? Icons.star : Icons.star_border,
                      size: 35,
                      color: Colors.white,
                    ), onPressed: (){
                      setState(() {
                        ratingValue = 3;
                      });
                    }),
                    IconButton(icon: Icon(
                      ratingValue >= 4 ? Icons.star : Icons.star_border,
                      size: 35,
                      color: Colors.white,
                    ), onPressed: (){
                      setState(() {
                        ratingValue = 4;
                      });
                    }),
                    IconButton(icon: Icon(
                      ratingValue >= 5 ? Icons.star : Icons.star_border,
                      size: 35,
                      color: Colors.white,
                    ), onPressed: (){
                      setState(() {
                        ratingValue = 5;
                      });
                    }),
                  ],
                ),
                SizedBox(height: 16,),
                Divider(color: Colors.grey, height: 2,),
                !isLoadingDialog
                    ? !doneRequest ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoadingDialog = true;
                          print('Enviar');
                        });
                        String response = await apiNotification.sendRating(ratingValue, 1);
                        setState(() {
                          isLoadingDialog = false;
                          doneRequest = true;
                        });
                        if(response == '200') {
                          setState(()  {
                            responseMessage = 'Avaliação enviada com sucesso.';
                          });
                          await Future.delayed(Duration(seconds: 4));
                          doneRequest = false;
                          Navigator.pop(context);
                        }else{
                          setState(()  {
                            responseMessage = 'Falha ao enviar a avaliação.';
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
}