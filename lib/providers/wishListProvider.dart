
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/models/productModel.dart';
class WishListProvider extends ChangeNotifier {
  addWishListData({
    String? wishListId, wishListName, wishListImage,
    int? wishListPrice, wishListQuantity
  }) async {
    await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .set({
      'wishListId': wishListId,
      'wishListName': wishListName,
      'wishListImage': wishListImage,
      'wishListPrice': wishListPrice,
      'wishListQuantity': wishListQuantity,
      'wishList': true
    });
    notifyListeners();
  }
  List<ProductModel?> wishList = [];
  getWishListData() async {
    List<ProductModel?> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourWishList').get();
    for (var element in value.docs) {
      ProductModel? productModel = ProductModel(
          productId: element.get('wishListId'),
          productImage: element.get('wishListImage'),
          productName: element.get('wishListName'),
          productPrice: element.get('wishListPrice'),
          productQuantity: element.get('wishListQuantity')
      );
      newList.add(productModel);
    }
    wishList = newList;
    notifyListeners();
  }
  List<ProductModel?> get getWishList =>wishList;

  deleteWishList(wishListId) async {
    FirebaseFirestore.instance.collection('WishList').doc(
        FirebaseAuth.instance.currentUser?.uid).collection('YourWishList').doc(wishListId).delete();
    notifyListeners();
  }
}