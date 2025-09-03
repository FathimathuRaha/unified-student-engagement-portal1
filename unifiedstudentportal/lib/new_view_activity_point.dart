// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifiedstudentportal/hms/pages/home_page.dart';
// import 'package:unifiedstudentportal/home.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(const ViewActivityPoint());
// }
//
// class ViewActivityPoint extends StatelessWidget {
//   const ViewActivityPoint({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Activity Point',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const ViewTotalActivityPoint(title: 'View Activity Point'),
//     );
//   }
// }
//
// class ViewTotalActivityPoint extends StatefulWidget {
//   const ViewTotalActivityPoint({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewTotalActivityPoint> createState() => _ViewTotalActivityPointState();
// }
//
// class _ViewTotalActivityPointState extends State<ViewTotalActivityPoint> {
//
//   _ViewTotalActivityPointState(){
//     ViewActivityPoint();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> point_ = <String>[];
//   List<String> eventdetails_ = <String>[];
//   List<String> eventcoordinator_ = <String>[];
//
//   Future<void> ViewActivityPoint() async {
//     List<String> id = <String>[];
//     List<String> point = <String>[];
//     List<String> eventdetails = <String>[];
//     List<String> eventcoordinator = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/std_view_activitypoint/';
//
//       var data = await http.post(Uri.parse(url), body: {
//
//         'lid':lid
//
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
//         point.add(arr[i]['point'].toString());
//         eventdetails.add(arr[i]['eventdetails'].toString());
//         eventcoordinator.add(arr[i]['eventcoordinator'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         point_ = point;
//         eventdetails_ = eventdetails;
//         eventcoordinator_ = eventcoordinator;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),);
//
//         return true;
//
//
//         },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( onPressed:() {
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyHomePage()),);
//
//           },),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         child:
//                         Row(
//                             children: [
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(point_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(eventdetails_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(eventcoordinator_[index]),
//                                   ),
//
//
//
//                                   ElevatedButton(
//                                     onPressed: () async {
//                                       SharedPreferences sh = await SharedPreferences.getInstance();
//                                       String url = sh.getString('url').toString();
//                                       String lid = sh.getString('lid').toString();
//
//                                       final urls = Uri.parse('$url/myapp/generate_certificate/');
//                                       try {
//                                         final response = await http.post(urls, body: {
//                                           'eid':id_[index],
//                                           'lid':lid,
//                                         });
//                                         if (response.statusCode == 200) {
//                                           String status = jsonDecode(response.body)['status'];
//                                           if (status=='ok') {
//
//                                             String cert =sh.getString('img_url').toString() +jsonDecode(response.body)['cert'];
//                                             _launchURL(cert);
//
//                                             Fluttertoast.showToast(msg: 'Download');
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Login',)));
//                                           }else {
//                                             Fluttertoast.showToast(msg: 'failed send');
//                                           }
//                                         }
//                                         else {
//                                           Fluttertoast.showToast(msg: 'Network Error');
//                                         }
//                                       }
//                                       catch (e){
//                                         Fluttertoast.showToast(msg: e.toString());
//                                       }
//
//                                     },
//                                     child: Text("Certificate"),
//                                   ),
//
//                                 ],
//                               ),
//
//                             ]
//                         ),
//
//                         elevation: 8,
//                         margin: EdgeInsets.all(10),
//                       ),
//                     ],
//                   )),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> _launchURL(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       Fluttertoast.showToast(msg: 'Could not launch $url');
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:unifiedstudentportal/viewcertificate.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ViewActivityPoint());
}

class ViewActivityPoint extends StatelessWidget {
  const ViewActivityPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Activity Point',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTotalActivityPoint(title: 'View Activity Point'),
    );
  }
}

class ViewTotalActivityPoint extends StatefulWidget {
  const ViewTotalActivityPoint({super.key, required this.title});

  final String title;

  @override
  State<ViewTotalActivityPoint> createState() => _ViewTotalActivityPointState();
}

class _ViewTotalActivityPointState extends State<ViewTotalActivityPoint> {
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> file_ = <String>[];
  List<String> category_ = <String>[];
  List<String> marks_ = <String>[];

  String amnt="";

  @override
  void initState() {
    super.initState();
    ViewActivityPoint();
  }

  Future<void> ViewActivityPoint() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> file = <String>[];
    List<String> category = <String>[];
    List<String> marks = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String img = sh.getString('img_url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/std_viewtotal_activity_point/';

      var response = await http.post(Uri.parse(url), body: {'lid': lid});

      var jsondata = json.decode(response.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      var tot = jsondata["tot"].toString();

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        file.add(img+arr[i]['file'].toString());
        category.add(arr[i]['category'].toString());
        marks.add(arr[i]['marks'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        file_ = file;
        category_ = category;
        marks_ = marks;
        amnt=tot;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(date_[index]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(category_[index]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(marks_[index]),
                          ),
                          Image(image: NetworkImage(file_[index]),height: 100,)



                          // ElevatedButton(onPressed: () async {
                          //   SharedPreferences sh = await SharedPreferences.getInstance();
                          //   sh.setString('aid', id_[index]);
                          //
                          //   Navigator.push(
                          //
                          //
                          //       context,
                          //       MaterialPageRoute(builder: (context) => ViewCertificatePage(title: '',)));
                          //
                          // }, child: Text("Certificate"))




                          // ElevatedButton(
                          //   onPressed: () async {
                          //     SharedPreferences sh =
                          //     await SharedPreferences.getInstance();
                          //     String url = sh.getString('url').toString();
                          //     String lid = sh.getString('lid').toString();
                          //
                          //     final urls =
                          //     Uri.parse('$url/myapp/generate_certificate/');
                          //
                          //     try {
                          //       final response = await http.post(urls, body: {
                          //         'eid': id_[index],
                          //         'lid': lid,
                          //       });
                          //
                          //       if (response.statusCode == 200) {
                          //         try {
                          //           // Try to parse JSON
                          //           var jsonResponse =
                          //           jsonDecode(response.body);
                          //           if (jsonResponse['status'] == 'ok') {
                          //             String cert = sh.getString('img_url').toString() + jsonResponse['certi'];
                          //             _launchURL(cert);
                          //             Fluttertoast.showToast(
                          //                 msg: 'Download started');
                          //           } else {
                          //             Fluttertoast.showToast(
                          //                 msg: 'Download failed');
                          //           }
                          //         } catch (e) {
                          //           // If parsing fails, assume it's a PDF
                          //           String pdfUrl = sh
                          //               .getString('img_url')
                          //               .toString() +
                          //               response.body;
                          //           _launchURL(pdfUrl);
                          //           Fluttertoast.showToast(msg: 'Opening PDF');
                          //         }
                          //       } else {
                          //         Fluttertoast.showToast(msg: 'Network Error');
                          //       }
                          //     } catch (e) {
                          //       Fluttertoast.showToast(msg: e.toString());
                          //     }
                          //   },
                          //   child: Text("Certificate"),
                          // ),
                        ],
                      ),
                      elevation: 8,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SendComplaintPage(title: 'Send Complaint')),
            // );
          },
          child: Text(amnt),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),

      ),
    );
  }

  // Future<void> _launchURL(String url) async {
  //   Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     Fluttertoast.showToast(msg: 'Could not launch $url');
  //   }
  // }
}



// Future<void> downloadCertificate(String eventId) async {
//   SharedPreferences sh = await SharedPreferences.getInstance();
//   String baseUrl = sh.getString('url') ?? "";
//   String imgBaseUrl = sh.getString('img_url') ?? "";
//   String lid = sh.getString('lid') ?? "";
//
//   final url = Uri.parse('$baseUrl/myapp/generate_certificate/');
//
//   try {
//     final response = await http.post(url, body: {'eid': eventId, 'lid': lid});
//
//     if (response.statusCode == 200) {
//       String contentType = response.headers['content-type'] ?? "";
//
//       // ✅ Handle PDF response directly
//       if (contentType.contains('application/pdf')) {
//         String certUrl = '$imgBaseUrl/myapp/generate_certificate/?eid=$eventId&lid=$lid';
//         _launchURL(certUrl);
//       }
//       // ✅ Handle JSON response (if certificate URL is sent)
//       else {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['status'] == 'ok' && jsonResponse.containsKey('certi')) {
//           String certUrl = imgBaseUrl + jsonResponse['certi'];
//           _launchURL(certUrl);
//         } else {
//           Fluttertoast.showToast(msg: 'Invalid response from server');
//         }
//       }
//     } else {
//       Fluttertoast.showToast(msg: 'Failed to download certificate');
//     }
//   } catch (e) {
//     Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//   }
// }
