import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/services/user_api_service.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';
import 'package:trocatalentos_app/widgets/customappbar.dart';
import 'dart:io';

class PerfilConfigScreen extends StatefulWidget {
  @override
  _PerfilConfigScreenState createState() => _PerfilConfigScreenState();
}

class _PerfilConfigScreenState extends State<PerfilConfigScreen> {
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _passwordController;
  TextEditingController _idadeController;
  File croppedFile;
  UserApiService api;

  @override
  void initState() {
    _emailController = TextEditingController(text: User.email);
    _nameController = TextEditingController(text: User.name);
    _passwordController = TextEditingController();
    _idadeController = TextEditingController(text: User.age);
    api = UserApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          title: 'Dados pessoais',
        ).build(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height*0.8,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImageFromGallery,
                          child: Container(
                            height: 140,
                            width: 140,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 15,
                                  child: Container(

                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Color(0xFF3CC9A4),
                                        width: 2
                                      )
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: croppedFile != null ? Image.file(croppedFile, fit: BoxFit.cover,) : Image.asset(
                                          'assets/images/avatar.png',
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  bottom: 20,
                                  child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Color(0xFF3CC9A4),
                                  ),
                                    child: Icon(Icons.edit,color: Colors.white, size: 20,),
                                ),),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "User name",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F9C7F)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          prefix: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          suffix: Icon(Icons.edit,color: Colors.white),
                          hint: 'Nome do usuário',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          prefix: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          suffix: Icon(Icons.edit,color: Colors.white),
                          hint: 'Email do usuário',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _idadeController,
                          prefix: Icon(
                            Icons.broken_image,
                            color: Colors.white,
                          ),
                          suffix: Icon(Icons.edit,color: Colors.white),
                          hint: 'Idade do usuário',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          prefix: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          suffix: Icon(Icons.edit,color: Colors.white),
                          hint: 'Cadastre nova senha',
                          textInputType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ],
                ),
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
              String name = _nameController.text;
              String email = _nameController.text;
              String password = _nameController.text;
              String age = _nameController.text;
              String response = await api.updateUserPerfil(croppedFile, name, email, password, age);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Color(0xFF2F9C7F),
            child: Text(
              'Atualizar dados pessoais',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ) :  Container(),
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
