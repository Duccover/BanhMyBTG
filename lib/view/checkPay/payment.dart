import 'package:flutter/material.dart';
import 'package:foodbany/models/deliverModel.dart';
import 'package:foodbany/view/checkPay/googlePay.dart';
import 'package:foodbany/view/checkPay/sucessPay.dart';
import 'package:provider/provider.dart';
import '../../providers/reviewCartProvider.dart';
import 'item/oderItem.dart';
import 'item/singleDeliverItem.dart';

enum payType { online, cash }

class Payment extends StatefulWidget {
  const Payment({Key? key, this.deliverAddressList}) : super(key: key);
  final DeliverModel? deliverAddressList;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var myType = payType.cash;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    int total = reviewCartProvider.getTotal();
    int shipping = 6;
    int totalShipping = (total + shipping) % 10;
    int totalAmount = (totalShipping + total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      bottomNavigationBar: ListTile(
        title: const Text('Tổng:'),
        subtitle: Text('$totalAmount\K'),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            color: Colors.orangeAccent,
            onPressed: () {
              myType == payType.online
                  ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GooglePay(),))
                  : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SuccessPay(),));
            },
            child: const Text(
              'Order Now',
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) =>
              Column(
                children: [
                  SingleDeliverItem(
                      fisrtName: widget.deliverAddressList?.firstName,
                      lastName: widget.deliverAddressList?.lastName,
                      phoneNumber: widget.deliverAddressList?.phoneNumber,
                      address: widget.deliverAddressList?.address),
                  const Divider(),
                  ExpansionTile(
                      title: Text(
                          'Mặt hàng: ${reviewCartProvider
                              .getReivewCartDataList.length}'),
                      children: reviewCartProvider.getReivewCartDataList.map((
                          e) {
                        return OrderItem(e);
                      }).toList()),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: const Text(
                      'Tổng',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('$total\K'),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: const Text(
                      'Phí ship',
                    ),
                    trailing: Text('$totalShipping\K'),
                  ),

                  RadioListTile(
                    value: payType.online,
                    groupValue: myType,
                    onChanged: (payType? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: const Icon(Icons.credit_card),
                    title: const Text('Chuyển khoản'),),
                  RadioListTile(
                    value: payType.cash,
                    groupValue: myType,
                    onChanged: (payType? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: const Icon(Icons.money),
                    title: const Text('Tiền Mặt'),)
                ],
              ),
        ),
      ),
    );
  }
}
