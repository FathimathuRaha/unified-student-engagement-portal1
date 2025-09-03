// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifiedstudentportal/home.dart';
// import 'package:unifiedstudentportal/sendcomplaints.dart';
//
// void main() {
//   runApp(const ViewReply());
// }
//
// class ViewReply extends StatelessWidget {
//   const ViewReply({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Reply',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const viewnotificationpage(title: 'View Reply'),
//     );
//   }
// }
//
// class viewnotificationpage extends StatefulWidget {
//   const viewnotificationpage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewnotificationpage> createState() => _viewnotificationpageState();
// }
//
// class _viewnotificationpageState extends State<viewnotificationpage> {
//
//   _viewnotificationpageState(){
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_= <String>[];
//   List<String> complaint_= <String>[];
//   List<String> reply_= <String>[];
//   List<String> status_= <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> complaint = <String>[];
//     List<String> reply = <String>[];
//     List<String> status = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/std_view_reply/';
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
//         date.add(arr[i]['date'].toString());
//         complaint.add(arr[i]['complaint'].toString());
//         reply.add(arr[i]['reply'].toString());
//         status.add(arr[i]['status'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         complaint_ = complaint;
//         reply_ = reply;
//         status_ = status;
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
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( onPressed:() {
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeNewPage(title: 'View Reply',)),);
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
//                                     child: Text(date_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(complaint_[index]),
//                                   ),    Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(reply_[index]),
//                                   ),  Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(status_[index]),
//                                   ),
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
//         floatingActionButton: FloatingActionButton(onPressed: () {
//
//           Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => sendcomplaintPage(title: 'Send Complaint',)));
//
//         },
//           child: Icon(Icons.plus_one),
//         ),
//
//
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:unifiedstudentportal/sendcomplaints.dart';

void main() {
  runApp(const Viewnotification());
}

class Viewnotification extends StatelessWidget {
  const Viewnotification({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewnotificationpage(title: 'view notification'),
    );
  }
}

class viewnotificationpage extends StatefulWidget {
  const viewnotificationpage({super.key, required this.title});

  final String title;

  @override
  State<viewnotificationpage> createState() => _viewnotificationpageState();
}

class _viewnotificationpageState extends State<viewnotificationpage> {
  _viewnotificationpageState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> event_= <String>[];
  List<String> Collegename_= <String>[];
  List<String> date_= <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> event = <String>[];
    List<String> Collegename = <String>[];
    List<String> date = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/viewnotification/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        event.add(arr[i]['event'].toString());
        Collegename.add(arr[i]['college name'].toString());
        // date.add(arr[i]['date'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        event_ = event;
        Collegename_ = Collegename;
      });

    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
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
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${date_[index]}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'event name: ${event_[index]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'college name: ${Collegename_[index]}',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      SizedBox(height: 8),
                      // Text(
                      //   'Status: ${status_[index]}',
                      //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => viewnotificationpage(title: 'view notification')),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}





