import 'package:flutter/material.dart';

class SingleDeliverItem extends StatelessWidget {
  final String? fisrtName,lastName , phoneNumber,address ;

   const SingleDeliverItem({ Key? key, this.fisrtName, this.address, this.lastName, this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Tên: $fisrtName', style: const TextStyle(fontSize: 25, color: Colors.black)),
              Text(
                   ' $lastName', style: const TextStyle(fontSize: 25, color: Colors.black))],
          ),
          leading: const CircleAvatar(
            radius: 8,
          ),
          subtitle: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Địa chỉ: $address'),
            const SizedBox(height: 5,),
            Text('Số điện thoại: $phoneNumber')
          ],),
        )
      ]
      ,
    );
  }
}
