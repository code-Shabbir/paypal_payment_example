
# Paypal Payment for Flutter - 2024🔥 

Integrate Paypal payment in your flutter app like never before! Supports both subscriptions and orders payment and for all platforms🥳
Using latest paypal apis so without wasting further more time let's jump into it 🤩

<br>

### **Key Features:**

* **Easy to use:** Use predefined paypal subscriptions/orders widgets made for u and see the magic. 
* **Instant support:** Anywhere u got stuck just drop a message and I am there to help u - 
[💬 Discord](https://discordapp.com/users/821022731192631316)
[💬 Whatsapp](https://wa.me/+919993828453)
* **Supports for all platform:** No worries of platforms will work like a charm in ios/android/web and all.
* **Latest paypal apis:** Package use latest api's from paypal so no headache for deprecations.
* **More custom code:** With more paypal orders/subscriptions methods customize as per ur need.

<br>

***Paypal payment examples:*

![](https://raw.githubusercontent.com/code-Shabbir/paypal_payment_example/master/paypal_order_1.webp)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![](https://raw.githubusercontent.com/code-Shabbir/paypal_payment_example/master/paypal_order_2.webp)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![](https://raw.githubusercontent.com/code-Shabbir/paypal_payment_example/master/paypal_subscription_2.webp)

<br>

## Installation

To install the PayPal Payment Package, follow these steps

1. Add the package to your project's dependencies in the `pubspec.yaml` file:
   ```yaml
   dependencies:
     paypal_payment: ^1.0.0
    ``` 
2. Run the following command to fetch the package:

    ``` 
    flutter pub get
    ``` 

## Usage
1. Import the package into your Dart file:

    ``` 
    import 'package:paypal_payment/paypal_payment.dart';
    ```
2. Orders: Navigate to the PayPal checkout view with the desired configuration:
    ```dart
    final String url = "http://localhost:63329/app/example";
    final String clientId = "*****";
    final String secretKey = "*****";
    final String currencyCode = "USD";
    final String? amount = "100";

    // Listen for callbacks for device not for web
    onSuccessCallback(value) => print("Paypal success callback $value");
    onErrorCallback(error) => print("Paypal error callback $error");
    onCancelCallback() => print("Paypal cancel callback");

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
    ```
3. Subscriptions: Navigate to the PayPal checkout view with the desired configuration:
    ```dart
    final String url = "http://localhost:63329/app/example";
    final String clientId = "*****";
    final String secretKey = "*****";
    final String currencyCode = "USD";
    final String? amount = "100";

    // Listen for callbacks for device not for web
    onSuccessCallback(value) => print("Paypal success callback $value");
    onErrorCallback(error) => print("Paypal error callback $error");
    onCancelCallback() => print("Paypal cancel callback");

    ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PaypalSubscriptionPayment(
                            sandboxMode: true,
                            clientId: clientId,
                            secretKey: secretKey,
                            productName: 'T-Shirt',
                            type: "PHYSICAL",
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
                                  "interval_unit": "MONTH",
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
    ```
4. Custom methods to call for orders and subscriptions:
    ```dart
    await PaypalOrderService.captureOrder(
        "v2/checkout/orders/${Uri.base.queryParameters['PayerID']}/capture",
        clientId: clientId,
        sandboxMode: true,
        secretKey: secretKey);
    PaypalSubscriptionService.createPlan()
    PaypalSubscriptionService.createProduct()
    ```

<br>

# ✅ Next steps

- Optimizing the code further.
- Regular updates.

<br>

## ⚡ Donate 

If you would like to support me, please consider making a donation through one of the following links:

* [PayPal](https://www.paypal.com/paypalme/shabbir940)
* ![](https://raw.githubusercontent.com/code-Shabbir/paypal_payment_example/master/paypal_qr_image.jpg)

Thank you for the support!
