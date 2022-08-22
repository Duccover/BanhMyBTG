import 'package:foodbany/models/productModel.dart';
import 'package:foodbany/view/search/searchData.dart';
import 'package:flutter/material.dart';
class Search extends StatefulWidget {
  List<ProductModel?> search;
   Search({Key? key, required this.search}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}
class _SearchState extends State<Search> {
  String query = '';
  searchItem(String query) {
    List<ProductModel?> searchFood = widget.search.where((element) {
      return element!.productName!.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }
  @override
  Widget build(BuildContext context) {
    List<ProductModel?> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.menu_rounded),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 52,
            child: TextField(
              onChanged: (value){
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Tìm kiếm',
                  suffixIcon: const Icon(Icons.search)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem
                .map((e) => SearchData(e?.productName.toString(),
                    e?.productImage, e?.productPrice,false,e?.productDesc.toString()))
                .toList(),
          )
        ],
      ),
    );
  }
}
