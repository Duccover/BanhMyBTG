import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodbany/models/addProductModel.dart';
import 'package:foodbany/view/image/getImage.dart';
import 'package:image_picker/image_picker.dart';

class HomePick extends StatefulWidget {
  const HomePick({Key? key}) : super(key: key);

  @override
  State<HomePick> createState() => _HomePickState();
}

class _HomePickState extends State<HomePick> {
  final name = TextEditingController();
  final price = TextEditingController();
  final desc = TextEditingController();
  List<String> multiImage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(hintText: 'productName'),
              ),
              TextField(
                controller: price,
                decoration: InputDecoration(hintText: 'productPrice'),
              ),
              TextField(
                controller: desc,
                decoration: InputDecoration(hintText: 'productDescs'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetImage(),
                        ));
                  },
                  child: Text('create  ')),
              ElevatedButton(
                  onPressed: () async {
                    List<XFile>? _images = await multiImagePick();
                    if (_images.isNotEmpty) {
                      final namee = name.text;
                      final prices = price.text;
                      final descc = desc.text;
                      multiImage = await multiImageUpLoad(
                          list: _images,
                          productName: namee,
                          productPrice: prices,
                          productDesc: descc);
                      setState(() {});
                      EasyLoading.showSuccess('Great Success!');
                    }
                  },
                  child: Text('multi')),
              Column(
                  children: multiImage
                      .map((e) => Image.network(
                            e,
                            fit: BoxFit.fill,
                          ))
                      .toList())
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> multiImageUpLoad(
      {required List<XFile> list,
      required String productName,
      productDesc,
      required String productPrice}) async {
    List<String> _path = [];
    for (XFile _image in list) {
      setState(() {});
      EasyLoading.show(status: 'uploading');
      _path.add(await uploadImage(
          productImage: _image,
          productName: productName,
          productDesc: productDesc,
          productPrice: productPrice));
    }
    return _path;
  }

  Future<List<XFile>> multiImagePick() async {
    List<XFile>? _image = await ImagePicker().pickMultiImage();
    if (_image != null && _image.isNotEmpty) {
      return _image;
    }
    return [];
  }
  Future<String> uploadImage(
      {required XFile productImage,
      String? productId,
      required String productName,
      required String productPrice,
      required String productDesc}) async {
    Reference db =
        FirebaseStorage.instance.ref('image/${getImageName(productImage)}');
    await db.putFile(File(productImage.path));
    final cc = await db.getDownloadURL();
    await FirebaseFirestore.instance.collection('Bread').doc(productId).set({
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productDesc': productDesc,
      'productImage': cc,

    });
    return cc;
  }

  String getImageName(XFile image) {
    return image.path.split('/').last;
  }
}
