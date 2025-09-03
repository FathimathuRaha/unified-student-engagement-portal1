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
//       home: const set_activity_point(title: 'ChangePassword'),
//     );
//   }
// }
//
// class set_activity_point extends StatefulWidget {
//   const set_activity_point({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<set_activity_point> createState() => _set_activity_pointState();
// }
//
// class _set_activity_pointState extends State<set_activity_point> {
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart%20';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/home.dart';  // Adjust this import if needed
import 'hms/pages/home_page.dart';
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
      home: const set_activity_point(title: 'Send Complaint'),
    );
  }
}

class set_activity_point extends StatefulWidget {
  const set_activity_point({super.key, required this.title});

  final String title;

  @override
  State<set_activity_point> createState() => _set_activity_pointState();
}

class _set_activity_pointState extends State<set_activity_point> {
  _set_activity_pointState(){
    view_notification();
  }
  TextEditingController complaintController = TextEditingController();
  String dropdownValue1 = '';
  String selectedCategoryId = '';
  Map<String, String> categoryMap = {}; // Map to store category names and IDs

  Future<void> view_notification() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/std_viewactivity_point/';

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        String id = arr[i]['id'].toString();
        String categoryname = arr[i]['category'].toString();
        categoryMap[categoryname] = id; // Store category name and ID in the map
      }

      setState(() {
        if (categoryMap.isNotEmpty) {
          dropdownValue1 = categoryMap.keys.first; // Initialize with the first category
          selectedCategoryId = categoryMap[dropdownValue1]!; // Initialize the selected ID
        }
      });

      print(categoryMap);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage != null) ...{
                  InkWell(
                    child: Image.file(_selectedImage!, height: 400),
                    radius: 399,
                    onTap: _checkPermissionAndChooseImage,
                  ),
                } else ...{
                  InkWell(
                    onTap: _checkPermissionAndChooseImage,
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                          height: 200,
                          width: 200,
                        ),
                        Text('Select Image', style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Category'),
                    DropdownButton<String>(
                      value: dropdownValue1,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue1 = value!;
                          selectedCategoryId = categoryMap[value]!; // Update the selected ID
                        });
                      },
                      items: categoryMap.keys.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    _send_data();
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _send_data() async {

    String category = selectedCategoryId; // Use the selected category ID
    String photos = photo;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/Uploadactivity_point/');
    try {
      final response = await http.post(urls, body: {

        'category': category,
        'photo': photos,
        'cid': category,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Successful');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(),));
        } else {
          Fluttertoast.showToast(msg: 'Already Added..or Something went to wrong..');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';
}

