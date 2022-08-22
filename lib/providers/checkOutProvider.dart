
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodbany/models/deliverModel.dart';

class CheckOutProvider extends ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  void validator(context) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: ' Insert Fisrt Name ');
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: ' Insert Last Name ');
    } else if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: ' Insert Your Phone Number ');
    } else if (address.text.isEmpty) {
      Fluttertoast.showToast(msg: ' Insert Your Address ');
    } else {
      await FirebaseFirestore.instance
          .collection('AddDelivery')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'firstName': firstName.text,
        'lastName': lastName.text,
        'address': address.text,
        'phoneNumber': phoneNumber.text
      }).then((value) =>
      {
        Fluttertoast.showToast(msg: 'Added Your Deliver Address'),
        Navigator.pop(context),
        notifyListeners()
      });
      notifyListeners();
    }
  }
List<DeliverModel> delivery =[];
     getDeliverData() async {
       List<DeliverModel> newList =[];
    DeliverModel? deliverModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance.collection(
        'AddDelivery').doc(FirebaseAuth.instance.currentUser?.uid).get();
      deliverModel = DeliverModel(
        firstName: _db.get('firstName'),
        lastName: _db.get('lastName'),
        address: _db.get('address'),
        phoneNumber: _db.get('phoneNumber'));
      newList.add(deliverModel);
    delivery = newList;
    notifyListeners();
  }
  List<DeliverModel> get getDelivery => delivery;
}
