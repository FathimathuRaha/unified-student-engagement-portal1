import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unifiedstudentportal/hms/constant/color.dart';
import 'package:unifiedstudentportal/hms/constant/text_style.dart';
import 'package:unifiedstudentportal/hms/models/event_model.dart';
import 'package:unifiedstudentportal/hms/pages/home_page.dart';
import 'package:unifiedstudentportal/hms/utils/datetime_utils.dart';
import 'package:unifiedstudentportal/hms/widgets/ui_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpComingEventCard extends StatelessWidget {
  final Event? event;
  final String photo;
  final String date;
  final String eventname;
  final String id;
  final VoidCallback onTap;
  const UpComingEventCard({Key? key,  this.event, required this.onTap, required this.photo,required this.id, required this.date, required this.eventname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: <Widget>[
          Expanded(child: buildImage()),
          UIHelper.verticalSpace(24),
          buildEventInfo(context),
        ],
      ),
    );
  }

  Widget buildImage() {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: imgBG,
          width: double.infinity,
          child: Hero(
            tag: photo,
            child: Image.network(
              photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(date, style: monthStyle),
              ElevatedButton(onPressed: ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String baseUrl = prefs.getString('url') ?? '';
    String userId = prefs.getString('lid') ?? '';
    String url = '$baseUrl/myapp/std_bookevents/';

    var response = await http.post(Uri.parse(url), body: {'eid': id, 'lid': userId});
    var jsonData = json.decode(response.body);

    if (jsonData['status'] == 'ok') {
    Fluttertoast.showToast(msg: 'Booked Successfully');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    // fetchEventDetails();
    } else if (jsonData['status'] == 'no') {
    Fluttertoast.showToast(msg: 'Ticket already booked');
    } else {
    Fluttertoast.showToast(msg: 'Booking failed');
    }
    // }
    // catch (e) {
    // Fluttertoast.showToast(msg: "Error: ${e.toString()}");

              }, child: Text('book')),

              // Text("hg", style: titleStyle),
            ],
          ),

        ),
        UIHelper.horizontalSpace(16),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(eventname, style: titleStyle),
            UIHelper.verticalSpace(4),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, size: 16, color: Theme.of(context).primaryColor),
                UIHelper.horizontalSpace(4),
                // Text("ghgfh".toUpperCase(), style: subtitleStyle),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
