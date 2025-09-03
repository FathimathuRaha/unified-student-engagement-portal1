import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:unifiedstudentportal/hms/pages/home_page.dart';

class ViewActivityPointPage extends StatefulWidget {
  final String title;
  const ViewActivityPointPage({super.key, required this.title});

  @override
  State<ViewActivityPointPage> createState() => _ViewActivityPointPageState();
}

class _ViewActivityPointPageState extends State<ViewActivityPointPage> {
  List<String> id_ = [];
  List<String> point_ = [];
  List<String> eventdetails_ = [];
  List<String> eventcoordinator_ = [];

  @override
  void initState() {
    super.initState();
    fetchActivityPoints();
  }

  Future<void> fetchActivityPoints() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      final response = await http.post(
        Uri.parse('$baseUrl/myapp/std_view_activitypoint/'),
        body: {'lid': lid},
      );

      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        List data = jsonData['data'];
        setState(() {
          id_ = data.map((item) => item['id'].toString()).toList();
          point_ = data.map((item) => item['point'].toString()).toList();
          eventdetails_ = data.map((item) => item['eventdetails'].toString()).toList();
          eventcoordinator_ = data.map((item) => item['eventcoordinator'].toString()).toList();
        });
      } else {
        Fluttertoast.showToast(msg: 'No activity points found.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
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
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
        ),
        body: id_.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: id_.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Event: ${eventdetails_[index]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Coordinator: ${eventcoordinator_[index]}"),
                    const SizedBox(height: 8),
                    Text("Points Earned: ${point_[index]}",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          String baseUrl = sh.getString('url') ?? '';
                          String lid = sh.getString('lid') ?? '';
                          String imgBaseUrl =
                              sh.getString('img_url') ?? '';

                          final certUrl =
                          Uri.parse('$baseUrl/myapp/generate_certificate/');
                          try {
                            final response = await http.post(certUrl, body: {
                              'eid': id_[index],
                              'lid': lid,
                            });

                            if (response.statusCode == 200) {
                              try {
                                var jsonResponse =
                                jsonDecode(response.body);
                                if (jsonResponse['status'] == 'ok') {
                                  String certUrl =
                                      imgBaseUrl + jsonResponse['certi'];
                                  _launchURL(certUrl);
                                  Fluttertoast.showToast(
                                      msg: 'Opening Certificate');
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Download failed');
                                }
                              } catch (_) {
                                // It's likely a PDF URL response
                                String pdfUrl =
                                    imgBaseUrl + response.body;
                                _launchURL(pdfUrl);
                                Fluttertoast.showToast(
                                    msg: 'Opening PDF');
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Network Error');
                            }
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        },
                        icon: Icon(Icons.picture_as_pdf),
                        label: Text("View Certificate"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
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
}
