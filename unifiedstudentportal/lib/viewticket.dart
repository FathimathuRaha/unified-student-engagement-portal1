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
//   runApp(const ViewTicket());
// }
//
// class ViewTicket extends StatelessWidget {
//   const ViewTicket({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Ticket',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const ViewTicketPage(title: 'View Ticket'),
//     );
//   }
// }
//
// class ViewTicketPage extends StatefulWidget {
//   const ViewTicketPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewTicketPage> createState() => _ViewTicketPageState();
// }
//
// class _ViewTicketPageState extends State<ViewTicketPage> {
//
//   _ViewTicketPageState(){
//     ViewTicket();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_= <String>[];
//   List<String> ticket_no_= <String>[];
//   List<String> eventdetails_= <String>[];
//
//   Future<void> ViewTicket() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> ticket_no = <String>[];
//     List<String> eventdetails = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/myapp/std_view_tickets/';
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
//         ticket_no.add(arr[i]['ticket_no'].toString());
//         eventdetails.add(arr[i]['eventdetails'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         ticket_no_ = ticket_no;
//         eventdetails_ = eventdetails;
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
//               MaterialPageRoute(builder: (context) => HomeNewPage(title: 'View Ticket',)),);
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
//                                     child: Text(ticket_no_[index]),
//                                   ),    Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(eventdetails_[index]),
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
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:unifiedstudentportal/viewbookingstatus.dart'; // Import for perforated effect

void main() {
  runApp(const ViewTicket());
}

class ViewTicket extends StatelessWidget {
  const ViewTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Ticket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTicketPage(title: 'View Ticket'),
    );
  }
}

class ViewTicketPage extends StatefulWidget {
  const ViewTicketPage({super.key, required this.title});

  final String title;

  @override
  State<ViewTicketPage> createState() => _ViewTicketPageState();
}

class _ViewTicketPageState extends State<ViewTicketPage> {
  String id_ = "";
  String date_ = "";
  String ticket_no_ = "";
  String eventdetails_ = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTicket();
  }

  Future<void> fetchTicket() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String bid = sh.getString('bid').toString();
      String url = '$urls/myapp/std_view_tickets/';

      var response = await http.post(Uri.parse(url), body: {'lid': lid,'bid':bid});
      var jsondata = json.decode(response.body);

      if (jsondata['status'] == 'ok' && jsondata["data"].isNotEmpty) {
        var ticket = jsondata["data"].first;

        setState(() {
          id_ = ticket['id'].toString();
          date_ = ticket['date'].toString();
          ticket_no_ = ticket['ticket_no'].toString();
          eventdetails_ = ticket['eventdetails'].toString();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "No ticket found");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewBookingStatusPage(title: '',)),
            );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : id_.isEmpty
          ? Center(child: Text("No ticket available"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: TicketCard(date_: date_, ticket_no_: ticket_no_, eventdetails_: eventdetails_),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String date_;
  final String ticket_no_;
  final String eventdetails_;

  const TicketCard({
    super.key,
    required this.date_,
    required this.ticket_no_,
    required this.eventdetails_,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Upper Section - Event Title
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                "🎭 $eventdetails_",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // Perforated Line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: DottedLine(dashLength: 8, lineThickness: 2, dashColor: Colors.grey),
          ),

          // Ticket Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInfoRow("📅 Date", date_),
                _buildInfoRow("🎫 Ticket No", ticket_no_),
              ],
            ),
          ),

          // Perforated Line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: DottedLine(dashLength: 8, lineThickness: 2, dashColor: Colors.grey),
          ),

          // QR Code Placeholder
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Column(
          //     children: [
          //       Icon(Icons.qr_code_2, size: 80, color: Colors.grey[700]),
          //       Text(
          //         "Show this ticket at the entrance",
          //         style: TextStyle(color: Colors.grey[600], fontSize: 14),
          //       ),
          //     ],
          //   ),
          // ),

          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: Colors.grey[700], fontSize: 16))),
        ],
      ),
    );
  }
}
