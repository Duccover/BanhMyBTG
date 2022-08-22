import 'package:flutter/material.dart';
class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hỗ trợ'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:const  [
             Text('Supporter: MR.DucDZ',style: TextStyle(fontSize: 30,color: Colors.red)),
            Divider(height: 20,),
            Text('Phone:0976594513',style: TextStyle(fontSize: 30,color: Colors.orange)),
          Divider(height: 20,),
          Text('Email: Nikebikedh1@gmail.com',style: TextStyle(fontSize: 20,color: Colors.orange))
        ],
      ),
    );
  }
}
