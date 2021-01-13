import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/services/auth_api_service.dart';
import 'package:trocatalentos_app/utilities/constants.dart';
import 'package:trocatalentos_app/widgets/custom_alertdialog.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = TextEditingController();
  bool _emailIsValid = false;
  AuthorizationApiService api = AuthorizationApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()=>Navigator.pop(context),
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
                        'Digite seu e-mail para recuperar sua senha',
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

                      SizedBox(
                        height: 25.0,
                      ),
                      _buildEmailTF(),
                      !_emailIsValid
                          ? Container(
                        margin: EdgeInsets.only(top: 8),
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
                        height: 50.0,
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



  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          onChanged: (value){
            _isEmailValid(value);
          },
          controller: _emailController,
          prefix: Icon(Icons.email, color: Colors.white,),
          hint: 'Digite seu e-mail',
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }



  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if(_emailIsValid){
            String response = await api.passwordRecovery(_emailController.text);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(messageContent: response == '200' ? 'E-mail de recuperação de senha enviado com sucesso.' : 'Erro ao recuperar a senha, por favor tente novamente');
              },
            );
            if (response == 200) {
              _emailController.clear();
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ENVIAR',
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
  }
   _isEmailValid(String email){
     setState(() {
       _emailIsValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
           .hasMatch(email);
     });
  }

}
