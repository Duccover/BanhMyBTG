import 'package:flutter/material.dart';
import 'package:foodbany/view/home/homePage.dart';

class SuccessPay extends StatelessWidget {
  const SuccessPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bany.png'), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Text(
                'BANH MY BTG',
                style: TextStyle(fontSize: 40, color: Colors.orange, shadows: [
                  BoxShadow(
                      blurRadius: 3,
                      color: Colors.green,
                      offset: Offset(1, 3))
                ]),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Cảm ơn bạn đã đặt hàng.\tVui lòng nghe máy khi Shipper đến.',
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
              ),
              const Divider(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
              }, child: const Text('Trang chủ'))
            ],
          )),
    );
  }
}
