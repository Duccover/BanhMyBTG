import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/auth/email/findPass.dart';
import 'package:foodbany/auth/email/register.dart';

class LogInGmail extends StatefulWidget {
  LogInGmail({Key? key}) : super(key: key);
  @override
  State<LogInGmail> createState() => _LogInGmailState();
}
class _LogInGmailState extends State<LogInGmail> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: pass  ,
                            decoration: InputDecoration(
                              hintText: 'Mật khẩu',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              InkWell(onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterGmail(),));
                              },child: Text('Đăng ký',style: TextStyle(fontSize: 17),),),
                              InkWell(onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FindPass(),));
                              },child: Text('Quên mật khẩu',style: TextStyle(fontSize: 17),),),
                            ],),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              signIn();
                            },
                            child: Text('Đăng nhập'),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: pass.text)
        .then((value) {
        Navigator.pop(context);
    });
  }
}
