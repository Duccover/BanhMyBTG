import 'package:foodbany/models/productModel.dart';
import 'package:foodbany/providers/wishListProvider.dart';
import 'package:foodbany/view/singleItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget {
  WishListProvider? wishListProvider;

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider?.getWishListData();
    showAlertDialog(BuildContext context, ProductModel delete) {
      Widget cancelButton = TextButton(
        child: const Text("Không"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Có"),
        onPressed: () {
          wishListProvider?.deleteWishList(delete.productId);
          Navigator.pop(context);
        },
      );
      AlertDialog alert = AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Bạn có muốn xóa không?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
      ),
      body: wishListProvider!.getWishList.isEmpty
          ? const Center(
              child: Text('Không có dữ liệu'),
            )
          : ListView.builder(
              itemCount: wishListProvider?.getWishList.length,
              itemBuilder: (context, index) {
                ProductModel? data = wishListProvider?.getWishList[index];
                return Column(
                  children: [
                    SingleItem(
                      productID: data?.productId,
                      productQuantity: data?.productQuantity,
                      productName: data?.productName,
                      productImage: data?.productImage,
                      productPrice: data?.productPrice,
                      isBool: false,
                      onDelete: () {
                        showAlertDialog(context, data!);
                      },
                    ),
                  ],
                );
              }),
    );
  }
}
