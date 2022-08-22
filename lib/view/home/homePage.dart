
import 'package:foodbany/providers/productProvider.dart';
import 'package:foodbany/view/search/search.dart';
import 'package:foodbany/view/home/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../reviewCart/reviewCart.dart';
import 'drawerHome.dart';
class HomePage extends StatelessWidget {
   const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Trang chủ',
          style: TextStyle(color: Colors.black),
        ),
        actions:  [
          CircleAvatar(
            radius: 18,
            backgroundColor:  Colors.orangeAccent,
            child: IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Search(search: provider.getAllDataSearch,),));
            }, icon: const Icon(Icons.search,size: 18,color: Colors.black,)),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const ReviewCart(),));
              },
              child: const CircleAvatar(
                child: Icon(
                  Icons.shop,
                  size: 18,
                  color: Colors.black,
                ),
                radius: 18,
                backgroundColor: Colors.orangeAccent,
              ),
            ),
          )
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.orangeAccent,
        child: DrawerHome()
      ),
      body:const SingleProduct()
    );
  }




}
