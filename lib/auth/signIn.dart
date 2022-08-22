
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:foodbany/auth/logInGmail.dart';
import 'package:foodbany/providers/facebookSignInProvider.dart';
import 'package:provider/provider.dart';
import '../providers/googleSignInProvider.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bany.png'), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'BANH MY\t',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.orange,
                                  offset: Offset(3, 3))
                            ])),
                    TextSpan(
                        text: 'BTG',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.orange,
                                  offset: Offset(3, 3))
                            ]))
                  ])),
                  SignInButton(Buttons.Email,text: 'Đăng nhập với Gmail', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInGmail(),));
                  }),
                  SignInButton(Buttons.Google, text: 'Đăng nhập với Google',
                      onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  }),
                  SignInButton(Buttons.Facebook,
                      text: 'Đang nhập với Facebook', onPressed: (){
                      var provider = Provider.of<FacebookSignInProvider>(context,listen: false);
                       provider.logInFacebook();
                      }),
                  Text(
                    'By signing you are agreeing to our \n \t \t \t \t Term and Pricacy Policy',
                    style: TextStyle(
                        color: Colors.grey[800], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
