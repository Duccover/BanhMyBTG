import 'package:foodbany/providers/reviewCartProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Count extends StatefulWidget {
  String? productName, productImage, productId;
  int? productPrice;
  var productUnit;
  Count(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productUnit})
      : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddAndQuannity() {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart')
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        isTrue = value.get('isAdd');
                        count = value.get('cartQuantity');
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuannity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
        width: 80,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        if (count == 1) {
                          setState(() {
                            isTrue = false;
                          });
                          reviewCartProvider
                              .reviewCartDataDelete(widget.productId);
                        } else {
                          setState(() {
                            count--;
                          });
                          reviewCartProvider.updateReviewCartData(
                              cartID: widget.productId,
                              cartImage: widget.productImage,
                              cartName: widget.productName,
                              cartPrice: widget.productPrice,
                              cartQuantity: count,
                              cartUnit: widget.productUnit);
                        }
                      },
                      child: const Icon(Icons.remove)),
                  Text(count.toString()),
                  InkWell(
                      onTap: () {
                        setState(() {
                          count++;
                        });
                        reviewCartProvider.updateReviewCartData(
                            cartID: widget.productId,
                            cartImage: widget.productImage,
                            cartName: widget.productName,
                            cartPrice: widget.productPrice,
                            cartQuantity: count,
                            cartUnit: widget.productUnit);
                      },
                      child: const Icon(Icons.add))
                ],
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartID: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    cartUnit: widget.productUnit
                  );
                },
                child: const Center(
                    child: Text(
                  'Thêm',
                  style: TextStyle(fontSize: 15),
                )),
              ));
  }
}
