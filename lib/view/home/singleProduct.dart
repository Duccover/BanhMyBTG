import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodbany/models/productModel.dart';
import 'package:foodbany/view/productUnit.dart';
import 'package:provider/provider.dart';
import '../../providers/productProvider.dart';
import '../count.dart';
import '../search/search.dart';
import '../viewDetail/productDetail.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key? key}) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int current = 0;
  final List<String> imageA = [
    'assets/banhmy1.png',
    'assets/banhmy2.png',
    'assets/banhmy3.png',
    'assets/banhmy4.png',
    'assets/banhmy6.png',
    'assets/banhmy5.png',
    'assets/banhmy7.png'
  ];

  @override
  void initState() {
    ProductProvider provider = Provider.of(context, listen: false);
    provider.fatchBread();
    provider.fatchDrinking();
    provider.fatchTopping();
    super.initState();
  }

  Future refresh() async {
    ProductProvider provider = Provider.of(context, listen: false);
    await provider.fatchBread();
    await provider.fatchDrinking();
    await provider.fatchTopping();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return RefreshIndicator(
      onRefresh: refresh,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Stack(
              children: [
                CarouselSlider(
                    items: imageA
                        .map((e) => SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image.asset(
                                e,
                                fit: BoxFit.fill,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, a) {
                          setState(() {
                            current = index;
                          });
                        })),
                Positioned(
                  left: 10,
                  child: Container(
                      height: 50,
                      width: 70,
                      decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: const Center(
                        child: Text(
                          'BTG',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.green,
                                    offset: Offset(3, 4))
                              ]),
                        ),
                      )),
                )
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageA.map((e) {
                  int index = imageA.indexOf(e);
                  return Container(
                    width: 8,
                    height: 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == index ? Colors.orange : Colors.grey),
                  );
                }).toList()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bánh mỳ'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    search:
                                        productProvider.getbreadProductData)));
                      },
                      child: const Text('Xem tất cả'))
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: productProvider.getbreadProductData.map((cc) {
                return BreadProduct(
                  productId: cc?.productId,
                  productName: cc?.productName,
                  productImage: cc?.productImage,
                  productPrice: cc?.productPrice,
                  productUnit: cc,
                  productDesc: cc?.productDesc,
                );
              }).toList()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Đồ uống'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    search: productProvider
                                        .getDrinkingProductData)));
                      },
                      child: const Text('Xem tất cả'))
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: productProvider.getDrinkingProductData.map((cc) {
                return DrinkingProduct(
                  productId: cc?.productId,
                  productName: cc?.productName,
                  productImage: cc?.productImage,
                  productPrice: cc?.productPrice,
                  productUnit: cc,
                  productDesc: cc?.productDesc,
                );
              }).toList()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Topping'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    search: productProvider
                                        .getToppingProductData)));
                      },
                      child: const Text('Xem tất cả'))
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: productProvider.getToppingProductData.map((cc) {
                return ToppingProduct(
                  productId: cc?.productId,
                  productName: cc?.productName,
                  productImage: cc?.productImage,
                  productPrice: cc?.productPrice,
                  productUnit: cc,
                  productDesc: cc?.productDesc,
                );
              }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class BreadProduct extends StatefulWidget {
  final String? productImage, productName, productId, productDesc;
  final int? productPrice;
  final ProductModel? productUnit;

  const BreadProduct(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productUnit,
      this.productDesc})
      : super(key: key);

  @override
  State<BreadProduct> createState() => _BreadProductState();
}

class _BreadProductState extends State<BreadProduct> {
  var uData, fisrtValue;

  @override
  Widget build(BuildContext context) {
    widget.productUnit?.productUnit?.firstWhere((element) {
      setState(() {
        fisrtValue = element;
      });
      return true;
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 180,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        productId: widget.productId,
                        productName: widget.productName,
                        productImage: widget.productImage,
                        productPrice: widget.productPrice,
                        productDesc: widget.productDesc,
                      ),
                    ));
              },
              child: Hero(
                tag: widget.productImage.toString(),
                child: Image.network(
                  widget.productImage.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Hero(
                    tag: widget.productName.toString(),
                    child: Text(
                      '${widget.productName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('${widget.productPrice}K/1 Cái'),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductUnit(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: widget.productUnit!.productUnit!
                                          .map((data) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    uData = data;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  data,
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  });
                            },
                            title: uData ?? fisrtValue),
                        Count(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                          productUnit: uData ?? fisrtValue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrinkingProduct extends StatefulWidget {
  final String? productImage, productName, productId, productDesc;
  final int? productPrice;
  final ProductModel? productUnit;

  const DrinkingProduct(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productUnit,
      this.productDesc})
      : super(key: key);

  @override
  State<DrinkingProduct> createState() => _DrinkingProductState();
}

class _DrinkingProductState extends State<DrinkingProduct> {
  var uData, fisrtValue;

  @override
  Widget build(BuildContext context) {
    widget.productUnit?.productUnit?.firstWhere((element) {
      setState(() {
        fisrtValue = element;
      });
      return true;
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 180,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                          productDesc: widget.productDesc),
                    ));
              },
              child: Hero(
                tag: widget.productImage.toString(),
                child: Image.network(
                  widget.productImage.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Hero(
                    tag: widget.productName.toString(),
                    child: Text(
                      '${widget.productName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('${widget.productPrice}K/1 Cốc'),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductUnit(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: widget.productUnit!.productUnit!
                                          .map((data) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    uData = data;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  data,
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  });
                            },
                            title: uData ?? fisrtValue),
                        Count(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                          productUnit: uData ?? fisrtValue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToppingProduct extends StatefulWidget {
  final String? productImage, productName, productId, productDesc;
  final int? productPrice;
  final ProductModel? productUnit;

  const ToppingProduct(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      this.productUnit,
      this.productDesc})
      : super(key: key);

  @override
  State<ToppingProduct> createState() => _ToppingProductState();
}

class _ToppingProductState extends State<ToppingProduct> {
  var uData, fisrtValue;

  @override
  Widget build(BuildContext context) {
    widget.productUnit?.productUnit?.firstWhere((element) {
      setState(() {
        fisrtValue = element;
      });
      return true;
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 180,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                          productDesc: widget.productDesc),
                    ));
              },
              child: Hero(
                tag: widget.productImage.toString(),
                child: Image.network(
                  widget.productImage.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Hero(
                    tag: widget.productName.toString(),
                    child: Text(
                      '${widget.productName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('${widget.productPrice}K/1 Cái'),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductUnit(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: widget.productUnit!.productUnit!
                                          .map((data) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    uData = data;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  data,
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  });
                            },
                            title: uData ?? fisrtValue),
                        Count(
                          productId: widget.productId,
                          productName: widget.productName,
                          productImage: widget.productImage,
                          productPrice: widget.productPrice,
                          productUnit: uData ?? fisrtValue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
