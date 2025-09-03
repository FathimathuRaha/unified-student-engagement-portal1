import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/home.dart';

import 'login.dart';
void main() {
  runApp(const SendFeedback());
}

class SendFeedback extends StatelessWidget {
  const SendFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Feedback',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SendFeedbackPage(title: 'Send Feedback'),
    );
  }
}

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key, required this.title});

  final String title;

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {


  @override
  Widget build(BuildContext context) {

    TextEditingController feedbackController= new TextEditingController();


    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: feedbackController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("feedback")),
                ),
              ),

              ElevatedButton(
                onPressed: () async {

                  String feedback= feedbackController.text.toString();


                  SharedPreferences sh = await SharedPreferences.getInstance();
                  String url = sh.getString('url').toString();
                  String lid = sh.getString('lid').toString();
                  String bid = sh.getString('bid').toString();

                  final urls = Uri.parse('$url/myapp/std_send_feedback/');
                  try {
                    final response = await http.post(urls, body: {
                      'feedback':feedback,
                      'lid':lid,
                      'cid':bid,



                    });
                    if (response.statusCode == 200) {
                      String status = jsonDecode(response.body)['status'];
                      if (status=='ok') {
                        Fluttertoast.showToast(msg: 'send Successfully');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),);
                      }else {
                        Fluttertoast.showToast(msg: 'failed send');
                      }
                    }
                    else {
                      Fluttertoast.showToast(msg: 'Network Error');
                    }
                  }
                  catch (e){
                    Fluttertoast.showToast(msg: e.toString());
                  }

                },
                child: Text("send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
