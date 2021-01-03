import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/services/talent_api_service.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';
import 'package:trocatalentos_app/widgets/sliders/tcoin_slider.dart';
import 'package:trocatalentos_app/model/talent.dart';

class CreateTalentScreen extends StatefulWidget {
  @override
  _CreateTalentScreenState createState() => _CreateTalentScreenState();
}

class _CreateTalentScreenState extends State<CreateTalentScreen> {
  double rating;
  TextEditingController _tituloController;
  TextEditingController _descricaoController;
  TalentApiService api;

  @override
  void initState() {
    _tituloController = TextEditingController();
    _descricaoController = TextEditingController();
    api = TalentApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Novo Talento',
        ).build(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.3,
                    width: width,
                    child: Image.network(
                      'https://as2.ftcdn.net/jpg/03/17/72/91/500_F_317729175_qLGD76QRMxcuxB34HWvf0cnlr34IqGpW.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        print('open images');
                      },
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
                padding: EdgeInsets.all(10),
                child: Container(
                  width:
                  MediaQuery.of(context).size.width *
                      0.5,
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Color(0xFF2F9C7F),
                        fontWeight: FontWeight.bold,
                      ),
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();

                      },
                      controller: _tituloController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            40),
                        UpperCaseTextFormatter(),
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
                        'Titulo do talento',
                        hintStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          color: Color(0XFF1E282C)
                              .withOpacity(0.19),
                        ),
                      ),
                    ),
                  ),
                ),
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
                padding: EdgeInsets.all(10),
                child: Container(
                  width:
                  MediaQuery.of(context).size.width *
                      0.85,
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14.0,
                          color: Color(0xFF2F9C7F),
                      ),
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();

                      },
                      controller: _descricaoController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            200),

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
                        'Escreva uma breve descrição sobre seu talento',
                        hintStyle: TextStyle(
                          fontFamily: 'Soleto',
                          fontSize: 14,
                          color: Color(0XFF1E282C)
                              .withOpacity(0.19),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SliderCustomTcoin(
                tittle: 'VALOR DO TALENTO',
                listValues: ['T\$ 1', 'T\$ 10'],
                value: rating??1,
                range: 100.0,
                onChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0 ? Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () async {
              TalentResponse response = await api.createTalent(_tituloController.text, _descricaoController.text);
              if(response.resultDetailTalent.talentId != null){
                print('salvou o talento');
              }else{
                print('não salvou o talento');
              }
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Color(0xFF2F9C7F),
            child: Text(
              'Salvar novo talento',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ): Container(),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}