import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/screens/configscreens/mytalents_screen.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'dart:io';
import 'package:trocatalentos_app/services/talent_api_service.dart';
import 'package:trocatalentos_app/widgets/custom_alertdialog.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';
import 'package:trocatalentos_app/widgets/sliders/tcoin_slider.dart';
import 'package:trocatalentos_app/model/talent.dart';

import '../../config.dart';

class CreateTalentScreen extends StatefulWidget {
  final Talent talent;

  CreateTalentScreen({this.talent});
  @override
  _CreateTalentScreenState createState() => _CreateTalentScreenState();
}

class _CreateTalentScreenState extends State<CreateTalentScreen> {
  double tcoin;
  TextEditingController _tituloController;
  TextEditingController _descricaoController;
  TalentApiService api;
  File croppedFile;
  String banner;
  String titulo;
  bool isLoading = false;
  bool isUpdate = false;

  @override
  void initState() {
    _tituloController = TextEditingController();
    _descricaoController = TextEditingController();
    api = TalentApiService();
    if(widget.talent != null){
      isUpdate = true;
      banner = widget.talent.banner;
      titulo = widget.talent.talentTitle;
      _descricaoController = TextEditingController(text: widget.talent.descricao);
      _tituloController = TextEditingController(text: widget.talent.talentTitle);
      tcoin = widget.talent.tcoin.toDouble();
    }
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
          title: isUpdate ? 'Atualizar Talento' : 'Novo Talento',
        ).build(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.3,
                    width: width,
                    color: Colors.grey[200],
                    child: croppedFile != null ? Image.file(croppedFile, fit: BoxFit.cover,) : banner != null && banner != '' ? Image.network('${environment['baseUrl']}' +'/files/'+ banner, fit: BoxFit.cover,) : Container(),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 30,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xFF3CC9A4),
                      ),
                      child: Icon(Icons.edit,color: Colors.white, size: 20,),
                    ),),
                  Positioned(
                    child: GestureDetector(
                      onTap: _pickImageFromGallery,
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
                              titulo == null || titulo == '' ? "Titulo do Talento" : titulo,
                              textAlign: TextAlign.center,
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
                      onChanged: (value){
                        setState(() {
                          titulo = value;
                        });
                      },
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
                      maxLines: 5,
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
                value: tcoin??1,
                range: 100.0,
                onChanged: (value) {
                  setState(() {
                    tcoin = value;
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
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0 ? Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isUpdate ? Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: 60,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () async {
                  String response;
                  setState(() {
                    isLoading = true;
                  });
                  if(isUpdate){
                    response = await api.deleteTalentById(widget.talent.talentId);
                  }
                  setState(() {
                    isLoading = false;
                  });
                  print('RESULTADO DA CHAMADA FOI: $response');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(messageContent: response == '200' ? 'Talento deletado com sucesso.' : response);
                    },
                  ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())));

                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                color: Color(0xFF2F9C7F),
                child: isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
                    : Icon(Icons.delete_outline, color: Colors.white,),
              ),
            ) : Container(),
            isUpdate ? SizedBox(height: 8,) : Container(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width:  MediaQuery.of(context).size.width* (isUpdate ? 0.6 : 0.9),
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () async {
                  String response;
                  setState(() {
                    isLoading = true;
                  });
                  if(isUpdate){
                    response = await api.updateTalent(croppedFile, _tituloController.text, _descricaoController.text, tcoin.toInt(), widget.talent.talentId);
                  }else{
                    response = await api.createTalent(croppedFile, _tituloController.text, _descricaoController.text, tcoin.toString());
                  }
                  setState(() {
                    isLoading = false;
                  });
                  print('RESULTADO DA CHAMADA FOI: $response');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(messageContent: response == '200' ? 'Talento salvo com sucesso.' : 'Erro ao salvar talento, por favor tente novamente');
                    },
                  ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())));

                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF2F9C7F),
                child: isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
                    : Text(
                  isUpdate ? 'Atualizar talento' : 'Salvar novo talento',
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


          ],
        ): Container(),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg','jpeg'],
    );
    String path = result.files.first.path;
    String name = result.files.first.name;
    final croppedFileTemp = await imageSelected(File(path));
    setState(() {
      croppedFile = croppedFileTemp;
    });

  }

  Future imageSelected(File image) async {
    if (image != null) {
      File imageCropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
            ratioX: 1,
            ratioY: 1,
          ),
          maxWidth: 200,
          maxHeight: 200);
      return imageCropped;
    }
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