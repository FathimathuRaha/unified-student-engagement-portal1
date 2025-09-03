// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifiedstudentportal/home.dart';
//
// import 'login.dart';
// void main() {
//   runApp(const sendcomplaint());
// }
//
// class sendcomplaint extends StatelessWidget {
//   const sendcomplaint({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ChangePassword',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const sendcomplaintPage(title: 'ChangePassword'),
//     );
//   }
// }
//
// class sendcomplaintPage extends StatefulWidget {
//   const sendcomplaintPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<sendcomplaintPage> createState() => _sendcomplaintPageState();
// }
//
// class _sendcomplaintPageState extends State<sendcomplaintPage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     TextEditingController complaintController= new TextEditingController();
//
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: complaintController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Complaint")),
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: () async {
//
//                   String complaint= complaintController.text.toString();
//
//
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//                   String url = sh.getString('url').toString();
//                   String lid = sh.getString('lid').toString();
//
//                   final urls = Uri.parse('$url/myapp/std_send_complaint/');
//                   try {
//                     final response = await http.post(urls, body: {
//                       'complaint':complaint,
//                       'lid':lid,
//
//
//
//                     });
//                     if (response.statusCode == 200) {
//                       String status = jsonDecode(response.body)['status'];
//                       if (status=='ok') {
//                         Fluttertoast.showToast(msg: 'Send Successfully');
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Login',)));
//                       }else {
//                         Fluttertoast.showToast(msg: 'Send Failed');
//                       }
//                     }
//                     else {
//                       Fluttertoast.showToast(msg: 'Network Error');
//                     }
//                   }
//                   catch (e){
//                     Fluttertoast.showToast(msg: e.toString());
//                   }
//
//                 },
//                 child: Text("Send"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/home.dart';  // Adjust this import if needed
import 'login.dart';  // Adjust this import if needed

void main() {
  runApp(const SendComplaint());
}

class SendComplaint extends StatelessWidget {
  const SendComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Complaint',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SendComplaintPage(title: 'Send Complaint'),
    );
  }
}

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key, required this.title});

  final String title;

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController complaintController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Complaint TextField wrapped in Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: complaintController,
                      maxLines: 5, // Allow multiple lines for the complaint
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Complaint',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                // Send Button wrapped in Padding for better spacing
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      String complaint = complaintController.text.toString();

                      SharedPreferences sh = await SharedPreferences.getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/myapp/std_send_complaint/');
                      try {
                        final response = await http.post(urls, body: {
                          'complaint': complaint,
                          'lid': lid,
                        });

                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(msg: 'Complaint Sent Successfully');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home')),
                            );
                          } else {
                            Fluttertoast.showToast(msg: 'Failed to Send Complaint');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    child: Text("Send"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

