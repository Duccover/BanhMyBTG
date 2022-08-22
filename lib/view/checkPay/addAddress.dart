import 'package:flutter/material.dart';
import 'package:foodbany/providers/checkOutProvider.dart';
import 'package:foodbany/view/customTextField.dart';
import 'package:provider/provider.dart';
class AddDeliverAddress extends StatelessWidget {
  const AddDeliverAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm địa chỉ'),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 50,
        child: MaterialButton(
          onPressed: () {
            checkOutProvider.validator(context);
          },
          child: const Text(
            'Thêm',
            style: TextStyle(color: Colors.black),
          ),
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
              labText: 'Tên đầu',
              controller: checkOutProvider.firstName,
            ),
            CustomTextField(
              labText: 'Tên cuối',
              controller: checkOutProvider.lastName,
            ),
            CustomTextField(
              labText: 'Số điện thoại',
              controller: checkOutProvider.phoneNumber,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              labText: 'Địa chỉ',
              controller: checkOutProvider.address,
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [Text('Thêm vị trí')],
                ),
              ),
            ),
          ],
        ),
      ),
    );
}}
