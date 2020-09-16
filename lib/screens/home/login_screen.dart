import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trocatalentos_app/controllers/login_controller/login_controller.dart';
import 'package:trocatalentos_app/model/user.dart';
import 'package:trocatalentos_app/services/auth_api_service.dart';
import 'package:trocatalentos_app/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/screens/home/register_screen.dart';
import 'package:trocatalentos_app/widgets/custom_alertdialog.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';
import 'package:trocatalentos_app/screens/home/home_screen.dart';
import 'package:trocatalentos_app/screens/home/forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController;
  bool errorTextField = false;
  AuthorizationApiService authApi;

  @override
  void initState() {
    loginController = LoginController();
    authApi = AuthorizationApiService();
    super.initState();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          onChanged: loginController.setEmail,
          prefix: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hint: 'Digite seu e-mail',
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Observer(builder: (_) {
          return CustomTextField(
            prefix: Icon(
              Icons.email,
              color: Colors.white,
            ),
            onChanged: loginController.setPassword,
            hint: 'Digite sua senha',
            textInputType: TextInputType.emailAddress,
            obscure: !loginController.passwordVisible ? true : false,
            suffix: IconButton(
              icon: Icon(
                !loginController.passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: loginController.togglePasswordVisibility,
            ),
          );
        })
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgotScreen())),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Esqueci a senha',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Observer(
      builder: (_) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () async {
              if (loginController.isEmailValid) {
                loginController.loading = true;
                await authApi.authorize(
                    loginController.email, loginController.password);
                loginController.loading = false;
                if (User.userId != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog();
                    },
                  );
                }
              } else {
                setState(() {
                  errorTextField = true;
                });
              }
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: loginController.loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xFF2F9C7F)),
                  )
                : Text(
                    'LOGIN',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
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
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Faça seu login',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nunito',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      errorTextField
                          ? Container(
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
                          : Container(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ainda não possui cadastro ?',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen())),
                              padding: EdgeInsets.only(right: 0.0),
                              child: Text(
                                'Cadastre-se',
                                style: kLabelStyle,
                              ),
                            ),
                          )
                        ],
                      )
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
}
