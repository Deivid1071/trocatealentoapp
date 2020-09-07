import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trocatalentos_app/utilities/constants.dart';
import 'package:trocatalentos_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _rememberMe = false;

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
          prefix: Icon(Icons.email, color: Colors.white,),
          hint: 'Digite seu nome',
          textInputType: TextInputType.emailAddress,
        ),
      ],
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
          prefix: Icon(Icons.email, color: Colors.white,),
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
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          prefix: Icon(Icons.email, color: Colors.white,),
          hint: 'Digite sua senha',
          textInputType: TextInputType.emailAddress,
          obscure: true,
          suffix: IconButton(
            icon: Icon(Icons.visibility_off, color: Colors.white,),
            onPressed: (){

            },
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirme sua senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        CustomTextField(
          prefix: Icon(Icons.email, color: Colors.white,),
          hint: 'Digite sua senha',
          textInputType: TextInputType.emailAddress,
          obscure: true,
          suffix: IconButton(
            icon: Icon(Icons.visibility_off, color: Colors.white,),
            onPressed: (){

            },
          ),
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
        onPressed: () => print('Botão de cadastro pressionado'),
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
}
