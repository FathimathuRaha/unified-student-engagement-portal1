import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/home.dart';
import 'package:unifiedstudentportal/viewbookingstatus.dart';

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

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const nearestevent(title: 'View Event Details',),
    );
  }
}

class nearestevent extends StatefulWidget {
  const nearestevent({super.key, required this.title});

  final String title;

  @override
  State<nearestevent> createState() => _nearesteventState();
}

class _nearesteventState extends State<nearestevent> {

  _nearesteventState(){
    ViewEventDetails();
  }

  List<String> id_ = <String>[];
  List<String> event_name_= <String>[];
  List<String> date_= <String>[];
  List<String> duration_= <String>[];
  List<String> venue_= <String>[];
  List<String> College_name_= <String>[];
  List<String> poster_= <String>[];
  List<String> point_= <String>[];
  List<String> amount_= <String>[];

  Future<void> ViewEventDetails() async {
    List<String> id = <String>[];
    List<String> event_name = <String>[];
    List<String> date = <String>[];
    List<String> duration= <String>[];
    List<String> venue= <String>[];
    List<String> College_name= <String>[];
    List<String> poster= <String>[];
    List<String> point= <String>[];
    List<String> amount= <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String img = sh.getString('img_url').toString();
      String lat = sh.getString('lat').toString();
      String long = sh.getString('lon').toString();
      String url = '$urls/myapp/view_event_nearest_events/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid,
        'lat':lat,
        'lon':long
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        event_name.add(arr[i]['event_name'].toString());
        duration.add(arr[i]['duration'].toString());
        venue.add(arr[i]['venue'].toString());
        College_name.add(arr[i]['College_name'].toString());
        poster.add(img+arr[i]['poster'].toString());
        point.add(arr[i]['point'].toString());
        amount.add(arr[i]['amount'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        event_name_ = event_name;
        duration_ = duration;
        venue_ = venue;
        College_name_ = College_name;
        poster_ = poster;
        point_ = point;
        amount_ = amount;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body:
        ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child:
                        Row(
                            children: [
                              Column(
                                children: [

                                  Image(image: NetworkImage(poster_[index]),height: 80,width: 80,),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(date_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(event_name_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(venue_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(College_name_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(duration_[index]),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(point_[index]),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(amount_[index]),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {



                                      SharedPreferences sh = await SharedPreferences.getInstance();
                                      String url = sh.getString('url').toString();
                                      String lid = sh.getString('lid').toString();

                                      final urls = Uri.parse('$url/myapp/std_bookevents/');
                                      try {
                                        final response = await http.post(urls, body: {
                                          'eid':id_[index],
                                          'lid':lid,

                                        });
                                        if (response.statusCode == 200) {
                                          String status = jsonDecode(response.body)['status'];
                                          if (status=='ok') {
                                            Fluttertoast.showToast(msg: 'Book Successfully');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => nearestevent(title: '',)));
                                          }else {
                                            Fluttertoast.showToast(msg: 'Send Failed');
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
                                    child: Text("Book"),
                                  ),

                                ],
                              ),

                            ]
                        ),

                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
