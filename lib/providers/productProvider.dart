
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/productModel.dart';
class ProductProvider extends ChangeNotifier{
ProductModel? productModel;
List<ProductModel?> search =[];
productModels(QueryDocumentSnapshot? element){
  productModel = ProductModel(
      productId: element?.get('productId'),
      productImage: element?.get('productImage'),
      productName: element?.get('productName'),
      productPrice: element?.get('productPrice'),
      productUnit: element?.get('productUnit'),
      productDesc: element?.get('productDesc')
  );
  search.add(productModel);
}
List<ProductModel?> get getAllDataSearch => search;


List<ProductModel?> breadProduct = [];
fatchBread() async{
  List<ProductModel?> newList= [];

  QuerySnapshot value = await FirebaseFirestore.instance.collection('Bread').get();
  for (var element in value.docs) {
     productModels(element);
    newList.add(productModel);
  }
  breadProduct = newList;
  notifyListeners();
}
List<ProductModel?> get getbreadProductData => breadProduct;


List<ProductModel?> drinkingProduct = [];
fatchDrinking() async{
  List<ProductModel?> newList= [];

  QuerySnapshot value = await FirebaseFirestore. instance.collection('Drinking').get();
  for (var element in value.docs) {
    productModels(element);
    newList.add(productModel);
  }
  drinkingProduct = newList;
  notifyListeners();
}

List<ProductModel?> get getDrinkingProductData => drinkingProduct;


List<ProductModel?> toppingProduct = [];
fatchTopping() async{
  List<ProductModel?> newList= [];
  QuerySnapshot value = await FirebaseFirestore.instance.collection('Topping').get();
  for (var element in value.docs) {
    productModels(element);
    newList.add(productModel);
  }
  toppingProduct = newList;
  notifyListeners();
}

List<ProductModel?> get getToppingProductData => toppingProduct;


}