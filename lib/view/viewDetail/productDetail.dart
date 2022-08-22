import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/providers/wishListProvider.dart';
import 'package:foodbany/view/reviewCart/reviewCart.dart';
import 'package:provider/provider.dart';
import '../count.dart';

class ProductDetail extends StatefulWidget {
  String? productImage, productName, productId, productUnit, productDesc;
  int? productPrice, productQuantity;

  ProductDetail(
      {Key? key,
      this.productName,
      this.productUnit,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productQuantity,
      this.productDesc})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool wishList = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourWishList')
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  setState(() {
                    wishList = value.get('wishList');
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider? wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
        bottomNavigationBar: Row(
          children: [
            bottomNavigatorBar(
                Colors.white,
                Colors.black,
                Colors.white,
                'Yêu thích',
                wishList ? Icons.favorite : Icons.favorite_outline, () {
              setState(() {
                wishList = !wishList;
              });
              if (wishList == true) {
                wishListProvider?.addWishListData(
                    wishListId: widget.productId,
                    wishListImage: widget.productImage,
                    wishListName: widget.productName,
                    wishListPrice: widget.productPrice,
                    wishListQuantity: 2);
              } else {
                wishListProvider?.deleteWishList(widget.productId);
              }
            }),
            bottomNavigatorBar(Colors.black, Colors.yellow, Colors.black,
                'Đến giỏ hàng', Icons.shop_outlined, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReviewCart(),
                  ));
            })
          ],
        ),
        appBar: AppBar(
          title: const Text('Chi tiết'),
        ),
        body: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Hero(
                        tag: widget.productName.toString(),
                        child: Text(
                          widget.productName.toString(),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    subtitle: Hero(
                        tag: widget.productPrice.toString(),
                        child: Text(
                          '${widget.productPrice}\K/1 Phần',
                          style: const TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Hero(
                      tag: widget.productImage.toString(),
                      child: Image.network(
                        widget.productImage.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Miêu tả:',
                          style: TextStyle(fontSize: 25),
                        ),
                        Count(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Hero(
                      tag: widget.productDesc.toString(),
                      child: Text(
                        widget.productDesc.toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget bottomNavigatorBar(Color iconColor, Color backgroundColor, color,
      String title, IconData iconData, Function() onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 26,
                color: iconColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
