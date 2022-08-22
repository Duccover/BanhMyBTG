import 'package:flutter/material.dart';
import 'package:foodbany/providers/reviewCartProvider.dart';
import 'package:provider/provider.dart';
import 'count.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleItem extends StatefulWidget {
  bool? isBool = false;
  bool? wishList = false;
  String? productName, productImage, productID;
  int? productQuantity, productPrice;
  Function()? onDelete;
  var productUnit;
  SingleItem(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.isBool,
      this.productID,
      this.productQuantity,
      this.onDelete,
        this.productUnit,
      this.wishList})
      : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}
class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider? reviewCartProvider;
  int? count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }
  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider?.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.network(
                            widget.productImage.toString(),
                          fit: BoxFit.fill,
                          )),
                    ),
                  )),

              Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: widget.isBool == false
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '${widget.productPrice.toString()}\K',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            widget.isBool == false
                                ?  const Text('')
                                : Container(
                                  width: 90,
                                  height: 30,
                                  child: Row(
                                    children:const[
                                      Text('50 Gram'),
                                      Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.circular(8)),
                                )
                          ],
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    widget.isBool == false
                        ? InkWell(
                            child: Container(
                                alignment: Alignment.topRight,
                                height: 30,
                                width: double.infinity,
                                child: const Icon(Icons.delete)),
                            onTap: widget.onDelete)
                        : Count(
                            productId: widget.productID,
                            productName: widget.productName,
                            productImage: widget.productImage,
                            productPrice: widget.productPrice,

                          ),
                    widget.wishList == false
                        ? Container(
                            width: 70,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (count! == 1) {
                                          Fluttertoast.showToast(
                                              msg: 'Tối thiểu phải là 1',
                                          backgroundColor: Colors.red);
                                        } else {
                                          setState(() {
                                            count = count! - 1;
                                          });
                                          reviewCartProvider
                                              ?.updateReviewCartData(
                                                  cartID: widget.productID,
                                                  cartName: widget.productName,
                                                  cartImage:
                                                      widget.productImage,
                                                  cartPrice:
                                                      widget.productPrice,
                                                  cartQuantity: count,
                                          cartUnit: widget.productUnit);
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text(count.toString()),
                                  InkWell(
                                    onTap: () {
                                      if (count! < 50) {
                                        setState(() {
                                          count = count! + 1;
                                        });
                                        reviewCartProvider
                                            ?.updateReviewCartData(
                                                cartID: widget.productID,
                                                cartName: widget.productName,
                                                cartImage: widget.productImage,
                                                cartPrice: widget.productPrice,
                                                cartQuantity: count,
                                                cartUnit: widget.productUnit);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.add,
                                    ),
                                  )
                                ]))
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
