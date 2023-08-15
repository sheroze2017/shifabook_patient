import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            MaterialButton(
                child: Text('data'),
                onPressed: () async {
                  Stripe.instance.presentPaymentSheet();
                  //await makePayment();
                })
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentsheet();
      paymentIntent = await createPaymentIntent('', '');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  applePay:
                      const PaymentSheetApplePay(merchantCountryCode: '+92'),
                  googlePay: const PaymentSheetGooglePay(
                      merchantCountryCode: '+92', testEnv: true),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Sheroze'))
          .then((value) {});

      paymentsheet();
    } catch (error) {
      print(error);
    }
  }

  createPaymentIntent(String s, String t) {}

  paymentsheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text('Payment Successful')
                        ],
                      )
                    ],
                  ),
                ));
        paymentIntent = null;
      });
    } catch (e) {}
  }
}
