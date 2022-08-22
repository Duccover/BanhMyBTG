import 'package:flutter/material.dart';
class ProductUnit extends StatelessWidget {
  final Function()? onTap;
  final String? title;

const ProductUnit({Key? key, this.title,this.onTap}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(
              '$title',
              style: const TextStyle(fontSize: 10),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
