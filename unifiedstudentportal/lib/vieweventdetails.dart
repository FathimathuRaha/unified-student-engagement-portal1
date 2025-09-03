import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewEventDetails());
}

class ViewEventDetails extends StatelessWidget {
  const ViewEventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Event Details',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ViewEventDetailsPage(title: 'View Event Details'),
    );
  }
}

class ViewEventDetailsPage extends StatefulWidget {
  const ViewEventDetailsPage({super.key, required this.title});
  final String title;

  @override
  State<ViewEventDetailsPage> createState() => _ViewEventDetailsPageState();
}

class _ViewEventDetailsPageState extends State<ViewEventDetailsPage> {
  List<Map<String, String>> events = [];

  @override
  void initState() {
    super.initState();
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = prefs.getString('url') ?? '';
      String imageUrl = prefs.getString('img_url') ?? '';
      String url = '$baseUrl/myapp/std_view_eventdetails/';

      var response = await http.post(Uri.parse(url), body: {'val': ""});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          events = List<Map<String, String>>.from(jsonData["data"].map((e) => {
            "id": e['id'].toString(),
            "date": e['date'].toString(),
            "name": e['event_name'].toString(),
            "duration": e['duration'].toString(),
            "venue": e['venue'].toString(),
            "college": e['College_name'].toString(),
            "poster": imageUrl + e['poster'].toString(),
            "points": e['point'].toString(),
            "amount": e['amount'].toString(),
          }));
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching events: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white, onPressed: () => Navigator.pop(context)),
      ),
      body: events.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var event = events[index];
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(event['poster']!, height: 400, width: double.infinity, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 10),
                  Text(event['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                  SizedBox(height: 5),
                  Text("Date: ${event['date']}", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("Venue: ${event['venue']}", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("College: ${event['college']}", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("Duration: ${event['duration']}", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("Points: ${event['points']}", style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text("Amount: ₹${event['amount']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => bookEvent(event['id']!),
                    child: Text("Book Now", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> bookEvent(String eventId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = prefs.getString('url') ?? '';
      String userId = prefs.getString('lid') ?? '';
      String url = '$baseUrl/myapp/std_bookevents/';

      var response = await http.post(Uri.parse(url), body: {'eid': eventId, 'lid': userId});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Booked Successfully');
        fetchEventDetails();
      } else if (jsonData['status'] == 'no') {
        Fluttertoast.showToast(msg: 'Ticket already booked');
      } else {
        Fluttertoast.showToast(msg: 'Booking failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }
}
