import 'package:foodbany/models/reviewCart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewCartProvider extends ChangeNotifier {
  List<ReviewCartModel> reviewCartDataList = [];

  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart')
        .get();
    for (var element in reviewCartValue.docs) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          cartID: element.get('cartID'),
          cartName: element.get('cartName'),
          cartImage: element.get('cartImage'),
          cartPrice: element.get('cartPrice'),
          cartQuantity: element.get('cartQuantity'),
          cartUnit: element.get('cartUnit'));
      newList.add(reviewCartModel);
    }
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReivewCartDataList => reviewCartDataList;

  void addReviewCartData(
      {String? cartID,
      cartName,
      cartImage,
      int? cartPrice,
      cartQuantity,
      var cartUnit}) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart')
        .doc(cartID)
        .set({
      'cartID': cartID,
      'cartName': cartName,
      'cartImage': cartImage,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'cartUnit': cartUnit,
      'isAdd': true
    });
    notifyListeners();
  }

  void updateReviewCartData(
      {String? cartID,
      cartName,
      cartImage,
      int? cartPrice,
      cartQuantity,
      var cartUnit}) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart')
        .doc(cartID)
        .update({
      'cartID': cartID,
      'cartName': cartName,
      'cartImage': cartImage,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'cartUnit': cartUnit,
      'isAdd': true
    });
    notifyListeners();
  }

  reviewCartDataDelete(cartID) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart')
        .doc(cartID)
        .delete();
    notifyListeners();
  }

  getTotal() {
    int total = 0;
    for (var element in reviewCartDataList) {
      total += element.cartPrice! * element.cartQuantity!;
    }
    return total;
  }
}
