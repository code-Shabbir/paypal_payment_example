import 'package:paypal_payment/core/services/constant/enum.dart';
import 'package:paypal_payment/core/services/paypal_order_service.dart';
import 'package:paypal_payment/views/paypal_order_payment.dart';
import 'package:paypal_payment/views/paypal_subscription_payment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaypalPaymentExample extends StatefulWidget {
  const PaypalPaymentExample({super.key});

  @override
  State<PaypalPaymentExample> createState() => _PaypalPaymentExampleState();
}

class _PaypalPaymentExampleState extends State<PaypalPaymentExample> {
  // web url
  final String url = "http://localhost:63329/app/example";
  final String clientId = "*****";
  final String secretKey = "*****";
  final String currencyCode = "USD";
  final String? amount = "100";

  @override
  void initState() {
    super.initState();
    // For paypal orders only in web we need to capture the payment after successfull callback to web route
    if (kIsWeb && Uri.base.queryParameters['PayerID'] != null) {
      checkForCallback();
    }
  }

  // only for web
  checkForCallback() async {
    final response = await PaypalOrderService.captureOrder(
        "v2/checkout/orders/${Uri.base.queryParameters['PayerID']}/capture",
        clientId: clientId,
        sandboxMode: true,
        secretKey: secretKey);

    // now call your backend endpoint to procced as you want!
    // print(response);
  }

  // Listen for callbacks for device not for web
  onSuccessCallback(value) => print("Paypal success callback $value");
  onErrorCallback(error) => print("Paypal error callback $error");
  onCancelCallback() => print("Paypal cancel callback");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paypal Payment Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalOrderPayment(
                          sandboxMode: true,
                          returnURL: url,
                          cancelURL: url,
                          clientId: clientId,
                          secretKey: secretKey,
                          currencyCode: currencyCode,
                          amount: amount,
                          onSuccess: onSuccessCallback,
                          onError: onErrorCallback,
                          onCancel: onCancelCallback)));
                },
                child: const Text("Paypal Payment (Order)")),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PaypalSubscriptionPayment(
                            sandboxMode: true,
                            clientId: clientId,
                            secretKey: secretKey,
                            productName: 'T-Shirt',
                            type: PRODUCT_TYPE.PHYSICAL.name,
                            planName: 'T-shirt plan',
                            billingCycles: [
                              {
                                'tenure_type': 'REGULAR',
                                'sequence': 1,
                                "total_cycles": 12,
                                'pricing_scheme': {
                                  'fixed_price': {
                                    'currency_code': currencyCode,
                                    'value': amount
                                  }
                                },
                                'frequency': {
                                  "interval_unit": INTERVALUNIT.MONTH.name,
                                  "interval_count": 1
                                }
                              }
                            ],
                            paymentPreferences: const {
                              "auto_bill_outstanding": true
                            },
                            returnURL: url,
                            cancelURL: url,
                            onSuccess: onSuccessCallback,
                            onError: onErrorCallback,
                            onCancel: onCancelCallback,
                          )));
                },
                child: const Text("Paypal Payment (Subscription)"))
          ],
        ),
      ),
    );
  }
}
