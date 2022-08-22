import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FindPass extends StatefulWidget {
  const FindPass({Key? key}) : super(key: key);

  @override
  State<FindPass> createState() => _FindPassState();
}

class _FindPassState extends State<FindPass> {
  TextEditingController findPass = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: findPass,
                decoration: InputDecoration(hintText: 'Nhập Email của bạn'),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                resetPass();
              },
              child: Text('Gửi'),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: findPass.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Đã gửi yêu cầu đến ${findPass.text}.Vui lòng kiểm tra trong Gmail')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
