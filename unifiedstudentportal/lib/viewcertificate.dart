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
//   runApp(const ViewActivitycertificate());
// }
//
// class ViewActivitycertificate extends StatelessWidget {
//   const ViewActivitycertificate({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Activity certificate',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const ViewCertificatePage(title: 'View Activity certificate'),
//     );
//   }
// }
//
// class ViewCertificatePage extends StatefulWidget {
//   const ViewCertificatePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewCertificatePage> createState() => _ViewCertificatePageState();
// }
//
// class _ViewCertificatePageState extends State<ViewCertificatePage> {
//
//   _ViewCertificatePageState(){
//     ViewActivitycertificate();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> certificate_ = <String>[];
//   List<String> eventdetails_ = <String>[];
//   List<String> eventcoordinator_ = <String>[];
//
//   Future<void> ViewActivitycertificate() async {
//     List<String> id = <String>[];
//     List<String> certificate = <String>[];
//     List<String> eventdetails = <String>[];
//     List<String> eventcoordinator = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/std_view_activitycertificate/';
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
//         certificate.add(arr[i]['certificate'].toString());
//         eventdetails.add(arr[i]['eventdetails'].toString());
//         eventcoordinator.add(arr[i]['eventcoordinator'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         certificate_ = certificate;
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
//                                     child: Text(certificate_[index]),
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
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ViewActivitycertificate());
}

class ViewActivitycertificate extends StatelessWidget {
  const ViewActivitycertificate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Activity certificate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewCertificatePage(title: 'View Activity certificate'),
    );
  }
}

class ViewCertificatePage extends StatefulWidget {
  const ViewCertificatePage({super.key, required this.title});

  final String title;

  @override
  State<ViewCertificatePage> createState() => _ViewCertificatePageState();
}

class _ViewCertificatePageState extends State<ViewCertificatePage> {
  List<String> id_ = <String>[];
  List<String> certificate_ = <String>[];
  List<String> eventdetails_ = <String>[];
  // List<String> eventcoordinator_ = <String>[];

  @override
  void initState() {
    super.initState();
    ViewActivitycertificate();
  }

  Future<void> ViewActivitycertificate() async {
    List<String> id = <String>[];
    List<String> certificate = <String>[];
    List<String> eventdetails = <String>[];
    // List<String> eventcoordinator = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String aid = sh.getString('aid').toString();
      String url = '$urls/myapp/std_view_activitycertificate/';

      var response = await http.post(Uri.parse(url), body: {'lid': lid,'aid':aid,});

      var jsondata = json.decode(response.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        certificate.add(sh.getString('img_url').toString()+arr[i]['certificate'].toString());
        eventdetails.add(arr[i]['eventdetails'].toString());
      }

      setState(() {
        id_ = id;
        certificate_ = certificate;
        eventdetails_ = eventdetails;
        // eventcoordinator_ = eventcoordinator;
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
                            child: Text(certificate_[index]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(eventdetails_[index]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(certificate_[index]),
                          ),






                          ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sh =
                              await SharedPreferences.getInstance();
                              String url = sh.getString('url').toString();
                              String lid = sh.getString('lid').toString();

                              final urls =
                              Uri.parse('$url/myapp/generate_certificate/');

                              try {
                                final response = await http.post(urls, body: {
                                  'eid': id_[index],
                                  'lid': lid,
                                });

                                if (response.statusCode == 200) {
                                  try {
                                    // Try to parse JSON
                                    var jsonResponse =
                                    jsonDecode(response.body);
                                    if (jsonResponse['status'] == 'ok') {
                                      String cert = sh
                                          .getString('img_url')
                                          .toString() +
                                          jsonResponse['cert2'];
                                      _launchURL(cert);
                                      Fluttertoast.showToast(
                                          msg: 'Download started');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Download failed');
                                    }
                                  } catch (e) {
                                    // If parsing fails, assume it's a PDF
                                    String pdfUrl = sh
                                        .getString('img_url')
                                        .toString() +
                                        response.body;
                                    _launchURL(pdfUrl);
                                    Fluttertoast.showToast(msg: 'Opening PDF');
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: 'Network Error');
                                }
                              } catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                              }
                            },
                            child: Text("Download"),
                          ),
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
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
    }
  }
}
