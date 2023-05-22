import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String merchantId = 'YOUR_MERCHANT_ID';
  final String merchantKey = 'YOUR_MERCHANT_KEY';
  final String channelId = 'YOUR_CHANNEL_ID';
  final String txnAmount = '1.00';
  final String orderId = 'YOUR_ORDER_ID';
  final String callbackUrl = 'YOUR_CALLBACK_URL';

  // void initiateTransaction() async {
  //   try {
  //     // var response = AllInOneSdk.startTransaction(
  //     //     mid,
  //     //     orderId,
  //     //     amount,
  //     //     txnToken,
  //     //     "",
  //     //     isStaging,
  //     //     restrictAppInvoke,
  //     // );
  //     response.then((value) {
  //       debugPrint(value.toString());
  //       if (value!['RESPCODE' == '01']) {
  //         makeApiRequest();
  //       }
  //       setState(() {
  //         final result = value.toString();
  //       });
  //     }).catchError((onError) {
  //       if (onError is PlatformException) {
  //         setState(() {
  //           final result = "${onError.message} \n  ${onError.details}";
  //         });
  //       } else {
  //         setState(() {
  //           final result = onError.toString();
  //         });
  //       }
  //     });
  //   } catch (err) {
  //     final result = err.toString();
  //   }
  // }

  void makeApiRequest() async {
    // Replace the URL with your actual API endpoint
    const apiUrl = 'https://your-api-endpoint.com';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // API request was successful
        debugPrint('API request success');
        debugPrint(response.body);
      } else {
        // API request failed
        debugPrint('API request failed');
      }
    } catch (e) {
      // Error occurred during API request
      debugPrint('API request error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){},
          child:const Text("Payment"),
        ),
      ),
    );
  }
}
