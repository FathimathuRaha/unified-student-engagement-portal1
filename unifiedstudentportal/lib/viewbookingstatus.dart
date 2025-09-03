// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import 'package:http/http.dart' as http;
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:unifiedstudentportal/home.dart';
// //
// // void main() {
// //   runApp(const ViewBookingStatus());
// // }
// //
// // class ViewBookingStatus extends StatelessWidget {
// //   const ViewBookingStatus({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'View Booking Status',
// //       theme: ThemeData(
// //
// //         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
// //         useMaterial3: true,
// //       ),
// //       home: const ViewBookingStatusPage(title: 'View Booking Status'),
// //     );
// //   }
// // }
// //
// // class ViewBookingStatusPage extends StatefulWidget {
// //   const ViewBookingStatusPage({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<ViewBookingStatusPage> createState() => _ViewBookingStatusPageState();
// // }
// //
// // class _ViewBookingStatusPageState extends State<ViewBookingStatusPage> {
// //
// //
// //   late Razorpay _razorpay;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //
// //
// //     // Initializing Razorpay
// //     _razorpay = Razorpay();
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// //     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// //   }
// //
// //   @override
// //   void dispose() {
// //     // Disposing Razorpay instance to avoid memory leaks
// //     _razorpay.clear();
// //     super.dispose();
// //   }
// //
// //   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
// //     // Handle successful payment
// //     print("Payment Successful: ${response.paymentId}");
// //
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url').toString();
// //     String lid = sh.getString('lid').toString();
// //
// //     final urls = Uri.parse('$url/myapp/std_make_payment/');
// //     try {
// //       final response = await http.post(urls, body: {
// //         'lid':lid,
// //         'bid':id_,
// //
// //
// //
// //       });
// //       if (response.statusCode == 200) {
// //         String status = jsonDecode(response.body)['status'];
// //         if (status=='ok') {
// //
// //           Fluttertoast.showToast(msg: 'success');
// //
// //
// //
// //         }else {
// //           Fluttertoast.showToast(msg: 'Not Found');
// //         }
// //       }
// //       else {
// //         Fluttertoast.showToast(msg: 'Network Error');
// //       }
// //     }
// //     catch (e){
// //       Fluttertoast.showToast(msg: e.toString());
// //     }
// //
// //
// //
// //
// //
// //   }
// //
// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     // Handle payment failure
// //     print("Error in Payment: ${response.code} - ${response.message}");
// //   }
// //
// //   void _handleExternalWallet(ExternalWalletResponse response) {
// //     // Handle external wallet
// //     print("External Wallet: ${response.walletName}");
// //   }
// //
// //   Future<void> _openCheckout() async {
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String amount = sh.getString('amount').toString();
// //
// //
// //
// //     int am = int.parse(amount) * 100; // Corrected to multiply by 100 for Razorpay
// //
// //     var options = {
// //       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
// //       'amount': am, // Amount in paise (e.g., 2000 paise = Rs 20)
// //       'name': 'Flutter Razorpay Example',
// //       'description': 'Payment for the product',
// //       'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
// //       'external': {
// //         'wallets': ['paytm'] // List of external wallets
// //       }
// //     };
// //
// //     try {
// //       _razorpay.open(options);
// //     } catch (e) {
// //       debugPrint('Error: ${e.toString()}');
// //     }
// //   }
// //
// //
// //
// //
// //   _ViewBookingStatusPageState(){
// //     ViewBookingStatus();
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> status_ = <String>[];
// //   List<String> date_= <String>[];
// //   List<String> student_= <String>[];
// //   List<String> eventdetails_ = <String>[];
// //   List<String> amount_ = <String>[];
// //
// //   Future<void> ViewBookingStatus() async {
// //     List<String> id = <String>[];
// //     List<String> status = <String>[];
// //     List<String> date = <String>[];
// //     List<String> student = <String>[];
// //     List<String> eventdetails= <String>[];
// //     List<String> amount= <String>[];
// //
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/myapp/std_view_bookingstatus/';
// //
// //       var data = await http.post(Uri.parse(url), body: {
// //
// //         'lid':lid
// //
// //       });
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         date.add(arr[i]['date'].toString());
// //         status.add(arr[i]['statuss'].toString());
// //         student.add(arr[i]['student'].toString());
// //         eventdetails.add(arr[i]['eventdetails'].toString());
// //         amount.add(arr[i]['amount'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         date_ = date;
// //         status_ = status;
// //         student_ = student;
// //         eventdetails_ = eventdetails;
// //         amount_=amount;
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error ------------------- " + e.toString());
// //       //there is error during converting file image to base64 encoding.
// //     }
// //   }
// //
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //
// //
// //     return WillPopScope(
// //       onWillPop: () async{ return true; },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leading: BackButton( onPressed:() {
// //
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (context) => HomeNewPage(title: 'View Booking Status',)),);
// //
// //           },),
// //           backgroundColor: Theme.of(context).colorScheme.primary,
// //           title: Text(widget.title),
// //         ),
// //         body: ListView.builder(
// //           physics: BouncingScrollPhysics(),
// //           // padding: EdgeInsets.all(5.0),
// //           // shrinkWrap: true,
// //           itemCount: id_.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             return ListTile(
// //               onLongPress: () {
// //                 print("long press" + index.toString());
// //               },
// //               title: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Column(
// //                     children: [
// //                       Card(
// //                         child:
// //                         Row(
// //                             children: [
// //                               Column(
// //                                 children: [
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(date_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(eventdetails_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(status_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(student_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(5),
// //                                     child: Text(amount_[index]),
// //                                   ),
// //
// //
// //
// //
// //                                   if(status_[index]=='approved')...{
// //
// //                                     ElevatedButton(
// //                                       onPressed: () async {
// //                                         SharedPreferences sh = await SharedPreferences.getInstance();
// //                                         sh.setString('amount', amount_[index]);
// //
// //                                         _openCheckout(); // Pass the index to _openCheckout
// //                                       },
// //                                       child: Text("payment"),
// //                                     )
// //
// //                                   }
// //                                   else...{
// //
// //                                   }
// //                                 ],
// //                               ),
// //
// //                             ]
// //                         ),
// //
// //                         elevation: 8,
// //                         margin: EdgeInsets.all(10),
// //                       ),
// //                     ],
// //                   )),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifiedstudentportal/home.dart';
//
// void main() {
//   runApp(const ViewBookingStatus());
// }
//
// class ViewBookingStatus extends StatelessWidget {
//   const ViewBookingStatus({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Booking Status',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const ViewBookingStatusPage(title: 'View Booking Status'),
//     );
//   }
// }
//
// class ViewBookingStatusPage extends StatefulWidget {
//   const ViewBookingStatusPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewBookingStatusPage> createState() => _ViewBookingStatusPageState();
// }
//
// class _ViewBookingStatusPageState extends State<ViewBookingStatusPage> {
//   late Razorpay _razorpay;
//   List<String> id_ = <String>[];
//   List<String> status_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> student_ = <String>[];
//   List<String> eventdetails_ = <String>[];
//   List<String> amount_ = <String>[];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initializing Razorpay
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     // Fetch booking status
//     ViewBookingStatus();
//   }
//
//   @override
//   void dispose() {
//     // Disposing Razorpay instance to avoid memory leaks
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print("Payment Successful: ${response.paymentId}");
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String bid = sh.getString('bid').toString(); // Retrieve the booking ID
//
//     final urls = Uri.parse('$url/myapp/std_make_payment/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'bid': bid, // Pass the booking ID
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Payment successful');
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Error in Payment: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet
//     print("External Wallet: ${response.walletName}");
//   }
//
//   Future<void> _openCheckout(int index) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String amount = amount_[index];
//     int am = int.parse(amount) * 100; // Corrected to multiply by 100 for Razorpay
//
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
//       'amount': am, // Amount in paise (e.g., 2000 paise = Rs 20)
//       'name': 'Flutter Razorpay Example',
//       'description': 'Payment for the product',
//       'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
//       'external': {
//         'wallets': ['paytm'] // List of external wallets
//       }
//     };
//
//     try {
//       // Save the booking ID for later use in the payment success handler
//       sh.setString('bid', id_[index]);
//       sh.setString('amount', amount);
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: ${e.toString()}');
//     }
//   }
//
//   Future<void> ViewBookingStatus() async {
//     List<String> id = <String>[];
//     List<String> status = <String>[];
//     List<String> date = <String>[];
//     List<String> student = <String>[];
//     List<String> eventdetails = <String>[];
//     List<String> amount = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/std_view_bookingstatus/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid': lid
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         status.add(arr[i]['statuss'].toString());
//         student.add(arr[i]['student'].toString());
//         eventdetails.add(arr[i]['eventdetails'].toString());
//         amount.add(arr[i]['amount'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         status_ = status;
//         student_ = student;
//         eventdetails_ = eventdetails;
//         amount_ = amount;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async { return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeNewPage(title: 'View Booking Status',)),
//             );
//           }),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("Long press on item " + index.toString());
//               },
//               title: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Card(
//                       child: Row(
//                         children: [
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(date_[index]),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(eventdetails_[index]),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(status_[index]),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(student_[index]),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(amount_[index]),
//                               ),
//                               if (status_[index] == 'approved') ...{
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     _openCheckout(index); // Pass the index to _openCheckout
//                                   },
//                                   child: Text("Payment"),
//                                 ),
//
//                               }
//
//
//                               else if (status_[index] == 'paid') ...{
//                                   ElevatedButton(
//                                          onPressed: () async {
//                                                    },
//                                      child: Text("Ticket"),
//     ),}
//
//
//                             ],
//                           ),
//                         ],
//                       ),
//                       elevation: 8,
//                       margin: EdgeInsets.all(10),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:unifiedstudentportal/sendfeedback.dart';
import 'package:unifiedstudentportal/viewticket.dart';

void main() {
  runApp(const ViewBookingStatus());
}

class ViewBookingStatus extends StatelessWidget {
  const ViewBookingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Booking Status',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewBookingStatusPage(title: 'View Booking Status'),
    );
  }
}

class ViewBookingStatusPage extends StatefulWidget {
  const ViewBookingStatusPage({super.key, required this.title});

  final String title;

  @override
  State<ViewBookingStatusPage> createState() => _ViewBookingStatusPageState();
}

class _ViewBookingStatusPageState extends State<ViewBookingStatusPage> {
  late Razorpay _razorpay;
  List<String> id_ = <String>[];
  List<String> eid_ = <String>[];
  List<String> status_ = <String>[];
  List<String> date_ = <String>[];
  List<String> student_ = <String>[];
  List<String> eventdetails_ = <String>[];
  List<String> amount_ = <String>[];

  @override
  void initState() {
    super.initState();

    // Initializing Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Fetch booking status
    ViewBookingStatus();
  }

  @override
  void dispose() {
    // Disposing Razorpay instance to avoid memory leaks
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String bid = sh.getString('bid').toString(); // Retrieve the booking ID

    final urls = Uri.parse('$url/myapp/std_make_payment/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'bid': bid, // Pass the booking ID
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          ViewBookingStatus();
          Fluttertoast.showToast(msg: 'Payment successful');
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
  }

  Future<void> _openCheckout(int index) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String amount = amount_[index];
    int am = int.parse(amount) * 100; // Corrected to multiply by 100 for Razorpay

    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': am, // Amount in paise (e.g., 2000 paise = Rs 20)
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
    };

    try {
      // Save the booking ID for later use in the payment success handler
      sh.setString('bid', id_[index]);
      sh.setString('amount', amount);
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  Future<void> ViewBookingStatus() async {
    List<String> id = <String>[];
    List<String> status = <String>[];
    List<String> date = <String>[];
    List<String> student = <String>[];
    List<String> eventdetails = <String>[];
    List<String> amount = <String>[];
    List<String> eid = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/std_view_bookingstatus/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        eid.add(arr[i]['eid'].toString());
        date.add(arr[i]['date'].toString());
        status.add(arr[i]['statuss'].toString());
        student.add(arr[i]['student'].toString());
        eventdetails.add(arr[i]['eventdetails'].toString());
        amount.add(arr[i]['amount'].toString());
      }

      setState(() {
        id_ = id;
        eid_ = eid;
        date_ = date;
        status_ = status;
        student_ = student;
        eventdetails_ = eventdetails;
        amount_ = amount;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Date: ${date_[index]}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Event Details: ${eventdetails_[index]}'),
                      SizedBox(height: 8),
                      Text('Status: ${status_[index]}'),
                      SizedBox(height: 8),
                      Text('Student: ${student_[index]}'),
                      SizedBox(height: 8),
                      Text('Amount: ₹${amount_[index]}'),
                      SizedBox(height: 12),
                      if (status_[index] == 'approved') ...{
                        ElevatedButton(
                          onPressed: () async {
                            _openCheckout(index); // Pass the index to _openCheckout
                          },
                          child: Text("Proceed to Payment"),
                        ),
                      } else if (status_[index] == 'paid') ...{

                        Row(children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Add logic for ticket download or view

                              SharedPreferences sh = await SharedPreferences.getInstance();
                              sh.setString('bid', eid_[index]);




                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewTicketPage(title: '',)));




                            },
                            child: Text("View Ticket"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Add logic for ticket download or view

                              SharedPreferences sh = await SharedPreferences.getInstance();
                              sh.setString('bid', eid_[index]);




                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SendFeedbackPage(title: '',)));




                            },
                            child: Text("Feedback"),
                          ),
                        ],)







                      }
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


