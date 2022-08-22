import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RegisterGmail extends StatefulWidget {
  const RegisterGmail({Key? key}) : super(key: key);
  @override
  State<RegisterGmail> createState() => _RegisterGmailState();
}
class _RegisterGmailState extends State<RegisterGmail> {
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
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                            controller: pass,
                            decoration: InputDecoration(
                              hintText: 'Mật khẩu',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            ],),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            child: Text('Đăng Ký'),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 23)),
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
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: pass.text).then((value) {
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      print('${error.toString()}');
    });
  }
}

