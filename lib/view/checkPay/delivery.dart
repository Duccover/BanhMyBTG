import 'package:flutter/material.dart';
import 'package:foodbany/models/deliverModel.dart';
import 'package:foodbany/providers/checkOutProvider.dart';
import 'package:foodbany/view/checkPay/addAddress.dart';
import 'package:foodbany/view/checkPay/payment.dart';
import 'package:foodbany/view/checkPay/item/singleDeliverItem.dart';
import 'package:provider/provider.dart';

class DeliveryDetail extends StatefulWidget {
  const DeliveryDetail({Key? key}) : super(key: key);

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  DeliverModel? value;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider provider = Provider.of(context);
    provider.getDeliverData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao đến'),
      ),
      floatingActionButton: Visibility(
        visible: provider.getDelivery.isEmpty?false:true,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDeliverAddress(),
                ));
          },
          child: const Icon(Icons.add),
        )
      ),
      bottomNavigationBar: Container(
        width: 160,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: provider.getDelivery.isEmpty
              ? const Text('Thêm mới')
              : const Text('Thanh toán'),
          color: Colors.orangeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            provider.getDelivery.isEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDeliverAddress(),
                    ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Payment(
                        deliverAddressList: value,

                      ),
                    ));
          },
        ),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Giao đến'),
            leading: Icon(Icons.location_on_outlined),
          ),
          const Divider(
            height: 1,
            color: Colors.orangeAccent,
          ),
          provider.getDelivery.isEmpty
              ? const Center(child: Text('Không có dữ liệu'))
              : Column(
                  children: provider.getDelivery.map((e) {
                    setState(() {
                   value = e;
                    });
                  return SingleDeliverItem(
                    fisrtName: e.firstName,
                    lastName: e.lastName,
                    phoneNumber:e.phoneNumber,
                    address: e.address
                  );
                }).toList())
        ],
      ),
    );
  }
}
