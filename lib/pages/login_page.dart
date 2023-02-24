import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/widgets/login_page/login_form.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Row(
        children: [
          Container(
            color: Colors.brown[50],
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: LoginForm(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/images/undraw_educator_re_ju47.svg',
                height: 500,
              ),
            )
          ),
        ],
      )
    );
  }
}