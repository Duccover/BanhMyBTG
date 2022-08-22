import 'package:pay/pay.dart';
import 'package:flutter/material.dart';
class GooglePay extends StatelessWidget {
   GooglePay({Key? key}) : super(key: key);
   final _paymentItems = [
     const PaymentItem(
       label: 'Total',
       amount: '99.99',
       status: PaymentItemStatus.final_price,
     )
   ];
  onGooglePayResult(paymentResult) {
  }
  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
        paymentConfigurationAsset: 'sample_payment_configuration.json',
        paymentItems: _paymentItems,
        style: GooglePayButtonStyle.black,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 15.0),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
    );

  }
}
