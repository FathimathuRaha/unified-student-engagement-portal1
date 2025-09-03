// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifiedstudentportal/logindesign.dart';
//
// import 'login.dart';
// void main() {
//   runApp(const MyChangePassword());
// }
//
// class MyChangePassword extends StatelessWidget {
//   const MyChangePassword({super.key});
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
//       home: const MyChangePasswordPage(title: 'ChangePassword'),
//     );
//   }
// }
//
// class MyChangePasswordPage extends StatefulWidget {
//   const MyChangePasswordPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyChangePasswordPage> createState() => _MyChangePasswordPageState();
// }
//
// class _MyChangePasswordPageState extends State<MyChangePasswordPage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     TextEditingController currentpasswordController= new TextEditingController();
//     TextEditingController newpasswordController= new TextEditingController();
//     TextEditingController confirmpasswordController= new TextEditingController();
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
//                   controller: currentpasswordController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Current Password")),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: newpasswordController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("New Password")),
//                 ),
//               ),      Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: confirmpasswordController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm Password")),
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: () async {
//
//                   String currentp= currentpasswordController.text.toString();
//                   String newp= newpasswordController.text.toString();
//                   String confirmp= confirmpasswordController.text.toString();
//
//
//
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//                   String url = sh.getString('url').toString();
//                   String lid = sh.getString('lid').toString();
//
//                   final urls = Uri.parse('$url/myapp/std_changepassword/');
//                   try {
//                     final response = await http.post(urls, body: {
//                       'CurrentPassword':currentp,
//                       'NewPassword':newp,
//                       'ConfirmPassword':confirmp,
//                       'lid':lid,
//
//
//
//                     });
//                     if (response.statusCode == 200) {
//                       String status = jsonDecode(response.body)['status'];
//                       if (status=='ok') {
//                         Fluttertoast.showToast(msg: 'Password Changed Successfully');
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => MyLoginPage(title: 'Login',)));
//                       }else {
//                         Fluttertoast.showToast(msg: 'Incorrect Password');
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
//                 child: Text("ChangePassword"),
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
import 'package:unifiedstudentportal/logindesign.dart';  // Adjust the import if needed
import 'login.dart';  // Adjust the import if needed

void main() {
  runApp(const MyChangePassword());
}

class MyChangePassword extends StatelessWidget {
  const MyChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Password',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyChangePasswordPage(title: 'Change Password'),
    );
  }
}

class MyChangePasswordPage extends StatefulWidget {
  const MyChangePasswordPage({super.key, required this.title});

  final String title;

  @override
  State<MyChangePasswordPage> createState() => _MyChangePasswordPageState();
}

class _MyChangePasswordPageState extends State<MyChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController currentpasswordController = TextEditingController();
    TextEditingController newpasswordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();

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
                // Current Password Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: currentpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Current Password',
                      ),
                    ),
                  ),
                ),

                // New Password Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: newpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                      ),
                    ),
                  ),
                ),

                // Confirm Password Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ),
                ),

                // Change Password Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      String currentp = currentpasswordController.text;
                      String newp = newpasswordController.text;
                      String confirmp = confirmpasswordController.text;

                      SharedPreferences sh = await SharedPreferences.getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/myapp/std_changepassword/');
                      try {
                        final response = await http.post(urls, body: {
                          'CurrentPassword': currentp,
                          'NewPassword': newp,
                          'ConfirmPassword': confirmp,
                          'lid': lid,
                        });

                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(msg: 'Password Changed Successfully');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyLoginPage(title: 'Login')),
                            );
                          } else {
                            Fluttertoast.showToast(msg: 'Incorrect Password');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    child: Text("Change Password"),
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

