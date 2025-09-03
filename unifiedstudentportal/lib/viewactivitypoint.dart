import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hms/pages/home_page.dart';

void main() {
  runApp(const ViewActivityPoint());
}

class ViewActivityPoint extends StatelessWidget {
  const ViewActivityPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Points',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewActivityPointPage(title: 'My Activity Points'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewActivityPointPage extends StatefulWidget {
  final String title;
  const ViewActivityPointPage({super.key, required this.title});

  @override
  State<ViewActivityPointPage> createState() => _ViewActivityPointPageState();
}

class _ViewActivityPointPageState extends State<ViewActivityPointPage> {
  List<String> id_ = [], point_ = [], eventdetails_ = [], eventcoordinator_ = [];

  @override
  void initState() {
    super.initState();
    fetchActivityPoints();
  }

  Future<void> fetchActivityPoints() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = prefs.getString('url') ?? "";
      String lid = prefs.getString('lid') ?? "";
      String url = '$baseUrl/myapp/std_view_activitypoint/';

      var response = await http.post(Uri.parse(url), body: {'lid': lid});
      var data = json.decode(response.body);

      if (data['status'] == 'ok') {
        List entries = data["data"];
        setState(() {
          id_ = entries.map((e) => e['id'].toString()).toList();
          point_ = entries.map((e) => e['point'].toString()).toList();
          eventdetails_ = entries.map((e) => e['eventdetails'].toString()).toList();
          eventcoordinator_ = entries.map((e) => e['eventcoordinator'].toString()).toList();
        });
      }
    } catch (e) {
      print("Error fetching activity points: $e");
    }
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch URL');
    }
  }

  Future<void> _downloadCertificate(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String baseUrl = prefs.getString('url') ?? "";
      String imgUrl = prefs.getString('img_url') ?? "";
      String lid = prefs.getString('lid') ?? "";

      var url = Uri.parse('$baseUrl/myapp/generate_certificate/');
      var response = await http.post(url, body: {'eid': id_[index], 'lid': lid});

      if (response.statusCode == 200) {
        try {
          var jsonResp = jsonDecode(response.body);
          if (jsonResp['status'] == 'ok') {
            String certUrl = imgUrl + jsonResp['certi'];
            _launchURL(certUrl);
            Fluttertoast.showToast(msg: 'Opening Certificate');
          } else {
            Fluttertoast.showToast(msg: 'Certificate not available');
          }
        } catch (_) {
          // Handle raw PDF
          String certUrl = imgUrl + response.body;
          _launchURL(certUrl);
        }
      } else {
        Fluttertoast.showToast(msg: 'Network error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }),
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: id_.isEmpty
            ? Center(child: Text("No activity points found.", style: TextStyle(fontSize: 16)))
            : ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(12),
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Points: ${point_[index]}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text("Event: ${eventdetails_[index]}"),
                          SizedBox(height: 4),
                          Text("Coordinator: ${eventcoordinator_[index]}"),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.star, color: Colors.teal),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () => _downloadCertificate(index),
                        icon: Icon(Icons.download),
                        label: Text("Certificate"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
