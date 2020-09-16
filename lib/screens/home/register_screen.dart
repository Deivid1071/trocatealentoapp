import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trocatalentos_app/controllers/register_controller/register_controller.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/services/auth_api_service.dart';
import 'package:trocatalentos_app/utilities/constants.dart';
import 'package:trocatalentos_app/widgets/custom_alertdialog.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _rememberMe = false;
  RegisterController registerController;
  AuthorizationApiService authApi;

  @override
  void initState() {
    registerController = RegisterController();
    authApi = AuthorizationApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF3CC9A4),
        elevation: 0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF3CC9A4),
                      Color(0xFF37B895),
                      Color(0xFF32A687),
                      Color(0xFF2F9C7F),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nunito',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildNameTF(),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildEmailTF(),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildConfirmPasswordTF(),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          prefix: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hint: 'Digite seu nome',
          textInputType: TextInputType.emailAddress,
          onChanged: registerController.setNome,
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Observer(builder: (_){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'E-mail',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          CustomTextField(
            prefix: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hint: 'Digite seu e-mail',
            textInputType: TextInputType.emailAddress,
            onChanged: registerController.setEmail,
          ),
          !registerController.isEmailValid
              ? Container(
            padding: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Digite um e-mail válido',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Nunito',
              ),
            ),
          )
              : Container()
        ],
      );
    },);
  }

  Widget _buildPasswordTF() {
    return Observer(builder: (_){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Senha',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          CustomTextField(
            prefix: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hint: 'Digite sua senha',
            textInputType: TextInputType.emailAddress,
            obscure: registerController.passwordVisible ? false : true,
            onChanged: registerController.setPassword,
            suffix: IconButton(
              icon: Icon(
                !registerController.passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: registerController.togglePasswordVisibility,
            ),
          ),
          !registerController.isPasswordValid
              ? Container(
            padding: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Digite uma senha com no minimo 6 caracteres',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Nunito',
              ),
            ),
          )
              : Container()
        ],
      );
    });
  }

  Widget _buildConfirmPasswordTF() {
    return Observer(builder: (_){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Confirme sua senha',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          CustomTextField(
            prefix: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hint: 'Digite sua senha',
            textInputType: TextInputType.emailAddress,
            onChanged: registerController.setConfirmPassword,
            obscure: registerController.passwordVisible? false : true,
            suffix: IconButton(
              icon: Icon(
                !registerController.passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: registerController.togglePasswordVisibility,
            ),
          ),
          !registerController.isConfirmPasswordValid
              ? Container(
            padding: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Para confirmar digite a mesma senha novamente',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Nunito',
              ),
            ),
          )
              : Container()
        ],
      );
    });
  }

  Widget _buildLoginBtn() {
    return Observer(builder: (_){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            if (registerController.isEmailValid) {
              registerController.loading = true;
              UserResponse response =  await authApi.register(registerController.nome,
                  registerController.email, registerController.password);
              registerController.loading = false;
              if (User.name != null) {
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));*/
                registerController.loading = true;
                await Future.delayed(Duration(seconds: 1));
                await authApi.authorize(
                    registerController.email, registerController.password);
                registerController.loading = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                print('FUNCIONOU SEM ERRO');
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog();
                  },
                );
              }
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: registerController.loading
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFF2F9C7F)),
          )
              : Text(
            'CADASTRAR',
            style: TextStyle(
              color: Color(0xFF2F9C7F),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      );
    });
  }
}
