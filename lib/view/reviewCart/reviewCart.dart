import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodbany/view/checkPay/delivery.dart';
import 'package:provider/provider.dart';
import '../../models/reviewCart.dart';
import '../../providers/reviewCartProvider.dart';
import '../singleItem.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({Key? key}) : super(key: key);

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  ReviewCartProvider? reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    Widget cancelButton = TextButton(
      child: const Text("Không"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Có"),
      onPressed: () {
        reviewCartProvider?.reviewCartDataDelete(delete.cartID);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Thông Báo"),
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

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    reviewCartProvider?.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text('Tổng cộng'),
        subtitle: Text('${reviewCartProvider!.getTotal().toString()}\K'),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              if(reviewCartProvider!.getReivewCartDataList.isEmpty){
                Fluttertoast.showToast(msg: 'Không có dữ liệu');
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDetail(),));
              }
            },
            color: Colors.orangeAccent,
            child: const Text('Xác nhận'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: reviewCartProvider!.getReivewCartDataList.isEmpty
          ? const Center(
              child: Text('Không có dữ liệu'),
            )
          : ListView.builder(
              itemCount: reviewCartProvider?.getReivewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel? data =
                    reviewCartProvider?.getReivewCartDataList[index];
                return Column(
                  children: [
                    SingleItem(
                      productID: data?.cartID,
                      productQuantity: data?.cartQuantity,
                      productName: data?.cartName,
                      productImage: data?.cartImage,
                      productPrice: data?.cartPrice,
                      productUnit: data?.cartUnit,
                      isBool: false,
                      wishList: false,
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
