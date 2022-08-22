import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider extends ChangeNotifier{
  void logInFacebook()async {
    Map<String,dynamic> _userData;
    final facebookLoginResult = await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();
    final facebookAuthCredential = FacebookAuthProvider.credential(
        facebookLoginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    await FirebaseFirestore.instance.collection('users').doc().set({
      'imageUrl': userData['picture']['data']['url'],
      'name': userData['name']
    });
    notifyListeners();
  }
  void logOut()async{
await FacebookAuth.instance.logOut().then((value) => null);
      notifyListeners();
  }
}