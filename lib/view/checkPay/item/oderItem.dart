import 'package:flutter/material.dart';
import 'package:foodbany/models/reviewCart.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(this.e, {Key? key}) : super(key: key);
  final ReviewCartModel e;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network('${e.cartImage}',
          fit: BoxFit.fill,
          width: 60,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${e.cartName}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text('${e.cartPrice}\K')
          ],
        ),subtitle: Text('Số lượng: ${e.cartQuantity}'),);
  }
}
