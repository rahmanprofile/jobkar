// import 'dart:convert';
// import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class PaymentSetup extends StatefulWidget {
//   const PaymentSetup({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentSetup> createState() => _PaymentSetupState();
// }
//
// class _PaymentSetupState extends State<PaymentSetup> {
//
//   var cfPaymentGatewayService = CFPaymentGatewayService();
//   @override
//   void initState() {
//     super.initState();
//     cfPaymentGatewayService.setCallback(verifyPayment, onError);
//   }
//   var YOUR_CLIENT_ID = 'TEST369907dbe2aeaf34ef624eb281709963';
//   var YOUR_CLIENT_SECRET = 'TEST8c414e549f70bf86fe2a9504b3e04a1701d3eb17';
//   var YOUR_ORDER_ID = 'fe2a9504b3e04aiutgk1701d3eb17hy';
//   var developer_name = 'Rahman';
//   void verifyPayment(String orderId) {
//     print("Verify Payment");
//   }
//   void onError(CFErrorResponse errorResponse, String orderId) {
//     print("Error while making payment");
//   }
//   String orderId = "order_3242Eypmd5FgXn0CUfibZ5vWEfZ8GY";
//   String paymentSessionId = "session_ashfiurijksGFjhksdgfjkhsgfakhsdgfkjasgdfkjsgfdh";
//   CFEnvironment environment = CFEnvironment.SANDBOX;
//   CFSession? createSession() {
//     try {
//       var session = CFSessionBuilder().setEnvironment(environment).setOrderId(orderId).setPaymentSessionId(paymentSessionId).build();
//       return session;
//     } on CFException catch (e) {
//       print(e.message);
//     }
//     return null;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ElevatedButton(
//           onPressed: pay,
//           child: const Text("Payment"),
//         ),
//       ),
//     );
//   }
//   pay() async {
//     var url = Uri.parse('https://sandbox.cashfree.com/pg/orders');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'x-client-id': YOUR_CLIENT_ID,
//         'x-client-secret': YOUR_CLIENT_SECRET,
//         'x-api-version': "2022-09-01",
//         'x-request-id': developer_name,
//       },
//       body: jsonEncode({
//         'orderId': YOUR_ORDER_ID,
//         'orderAmount': 25.5,
//         'customerName': 'Rahman Flutter',
//         'customerPhone': '8052399848',
//         'customerEmail': 'rahman@gmail.com',
//         "order_note": "Let's see whats happen",
//         'notifyUrl': 'https://test.cashfree.com',
//       }),
//     );
//     if (response.statusCode == 200) {
//       try {
//         var session = createSession();
//         List<CFPaymentModes> components = <CFPaymentModes>[];
//         components.add(CFPaymentModes.UPI);
//         components.add(CFPaymentModes.CARD);
//         components.add(CFPaymentModes.WALLET);
//         var paymentComponent = CFPaymentComponentBuilder().setComponents(components).build();
//         var theme = CFThemeBuilder().setNavigationBarBackgroundColorColor("#FF0000").setPrimaryFont("Menlo").setSecondaryFont("Futura").build();
//         var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder().setSession(session!).setPaymentComponent(paymentComponent).setTheme(theme).build();
//         cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
//         print(response.body.toString());
//       } on CFException catch (e) {
//         print(e.message);
//       }
//     } else {
//       debugPrint('Request failed with status code: ${response.statusCode}');
//     }
//
//   }
// }
