import 'package:flutter/material.dart';
import 'package:foodbany/view/viewDetail/productDetail.dart';

class SearchData extends StatelessWidget {
  String? productImage, productName,productDesc;
  int? productPrice;
  bool? isBool = false;

  SearchData(
      this.productName, this.productImage, this.productPrice, this.isBool,this.productDesc,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    productName: productName,
                    productImage: productImage,
                    productPrice: productPrice,
                    productDesc: productDesc,
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.network(
                              productImage.toString(),
                              fit: BoxFit.fill,
                            )),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '$productPrice\K',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              const SizedBox(
                                width: 90,
                                height: 30,
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
