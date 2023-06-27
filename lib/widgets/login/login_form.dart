import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ontrack_backoffice/helpers/persistencia_user.dart';
import 'package:ontrack_backoffice/pages/login/forgot_password.dart';
import 'package:ontrack_backoffice/services/api_login.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/custom_text.dart';

import '../../controllers/login/login_form_controllers.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                text: 'Bem-Vindo,',
                size: 30,
                color: Colors.black,
                weight: FontWeight.bold,
                textAlign: TextAlign.left
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                text: 'Introduza os seus detalhes em baixo',
                size: 16,
                color: Colors.black,
                weight: FontWeight.normal,
                textAlign: TextAlign.left
            ),
          ),
          SizedBox(height: 50),
          _buildEmailTextField(),
          SizedBox(height: 30),
          _buildPasswordTextField(),
          SizedBox(height: 10),
          ForgotPassword(),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              padding: EdgeInsets.symmetric(horizontal: 132, vertical: 20)
            ),
            onPressed: () async {
              /*
              Verificar se o email é de professor ou aluno primeiro
               */
              var loginValue = await login(emailController.text, passwordController.text);
              if (loginValue > 0) {
                // Limpar os campos de texto
                passwordController.clear();

                // Guardar o id do utilizador
                await saveUserID(loginValue);
                await saveUserEmailENome(emailController.text, loginValue);
                GoRouter.of(context).push('/home');

              }else {
                //TODO: Show error message
                // loginVavlue pode ter valores entre -1 e -2, dependendo do valor mostrar um Snackbar com uma mensagem
                switch (loginValue) {
                  case -1:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text('Email introduzido inválido', style: TextStyle(fontSize: 20))),
                        backgroundColor: Colors.red,
                      ),
                    );
                    break;

                  case -2:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text('O email introduzido não se encontra registado', style: TextStyle(fontSize: 20))),
                        backgroundColor: Colors.red,
                      ),
                    );
                    break;
                }
              }
            },
            child: Text(
                'Login',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            ),
          )
        ]
      ),
    );
  }


  Widget _buildEmailTextField() {
    return Container(
      width: 400,
      child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                  text: 'Email de Professor',
                  size: 16,
                  color: Colors.black,
                  weight: FontWeight.bold,
                  textAlign: TextAlign.left
              ),
              ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'ex: p1234@ulusofona.pt',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    )
                ),
              ),
            )
          ]
      ),
    );
  }
}
  //password widget
  Widget _buildPasswordTextField() {
    return Container(
      width: 400,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                text: 'Password',
                size: 16,
                color: Colors.black,
                weight: FontWeight.bold,
                textAlign: TextAlign.left
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            width: 300,
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                hintText: 'ex: 1234',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                )
              ),
            ),
          )
        ]
      ),
    );
  }



class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Implemente aqui a ação que deseja executar ao clicar no texto
          Navigator.pushNamed(context, '/forgot_password');
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot password?',
            style: GoogleFonts.roboto(
              decoration: TextDecoration.underline,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
