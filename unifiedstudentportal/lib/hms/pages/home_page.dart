import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/hms/constant/text_style.dart';
import 'package:unifiedstudentportal/hms/models/event_model.dart';
import 'package:unifiedstudentportal/hms/nearestevents.dart';
import 'package:unifiedstudentportal/hms/pages/event_detail_page.dart';
import 'package:unifiedstudentportal/hms/utils/app_utils.dart';
import 'package:unifiedstudentportal/hms/widgets/bottom_navigation_bar.dart';
import 'package:unifiedstudentportal/hms/widgets/home_bg_color.dart';
import 'package:unifiedstudentportal/hms/widgets/nearby_event_card.dart';
import 'package:unifiedstudentportal/hms/widgets/ui_helper.dart';
import 'package:unifiedstudentportal/hms/widgets/upcoming_event_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:unifiedstudentportal/logindesign.dart';
import 'package:unifiedstudentportal/new.dart';
import 'package:unifiedstudentportal/new_view_activity_point.dart';
import 'package:unifiedstudentportal/sendfeedback.dart';
import 'package:unifiedstudentportal/viewactivitypoint.dart';
import 'package:unifiedstudentportal/viewbookingstatus.dart';
import 'package:unifiedstudentportal/vieweventdetails.dart';
import 'package:unifiedstudentportal/viewreply.dart';
import '../../changepassword.dart';
import '../../sendcomplaints.dart.';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  _MyHomePageState(){
    ViewEventDetails("");
    nearViewEventDetails();


  }
  int _currentIndex = 0;

  late ScrollController scrollController = ScrollController();
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..forward();
  late AnimationController opacityController = AnimationController(
    vsync: this,
    duration: const Duration(microseconds: 1),
  );
  late Animation<double> opacity;

  void viewEventDetail(event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            // child: EventDetailPage(event),
          );
        },
      ),
    );
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

  Future<void> ViewEventDetails(val) async {
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
      String url = '$urls/myapp/std_view_eventdetails/';

      var data = await http.post(Uri.parse(url), body: {

        'val':val

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





  List<String> nid_ = <String>[];
  List<String> nevent_name_= <String>[];
  List<String> ndate_= <String>[];
  List<String> nduration_= <String>[];
  List<String> nvenue_= <String>[];
  List<String> nCollege_name_= <String>[];
  List<String> nposter_= <String>[];
  List<String> npoint_= <String>[];
  List<String> namount_= <String>[];

  Future<void> nearViewEventDetails() async {
    List<String> nid = <String>[];
    List<String> nevent_name = <String>[];
    List<String> ndate = <String>[];
    List<String> nduration= <String>[];
    List<String> nvenue= <String>[];
    List<String> nCollege_name= <String>[];
    List<String> nposter= <String>[];
    List<String> npoint= <String>[];
    List<String> namount= <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String img = sh.getString('img_url').toString();
      String url = '$urls/myapp/view_event_nearest_events/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid,

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        nid.add(arr[i]['id'].toString());
        ndate.add(arr[i]['date'].toString());
        nevent_name.add(arr[i]['event_name'].toString());
        nduration.add(arr[i]['duration'].toString());
        nvenue.add(arr[i]['venue'].toString());
        nCollege_name.add(arr[i]['College_name'].toString());
        nposter.add(img+arr[i]['poster'].toString());
        npoint.add(arr[i]['point'].toString());
        namount.add(arr[i]['amount'].toString());
      }

      setState(() {
        nid_ = nid;
        ndate_ = ndate;
        nevent_name_ =nevent_name;
        nduration_ = nduration;
        nvenue_ = nvenue;
        nCollege_name_ = nCollege_name;
        nposter_ = nposter;
        npoint_ = npoint;
        namount_ = namount;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }


  @override
  void initState() {
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset, maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print(poster_.length);
    const inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    return Scaffold(
      key: _scaffoldKey,

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 18, 82, 98)),
              child: Text('', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: const Text(' Change Password '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePasswordPage(title: "Change Password",),));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: const Text(' Send Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SendFeedbackPage(title: "Prescription Details",),));
              },
            ),
                ListTile(
              leading: Icon(Icons.feedback),
              title: const Text(' Send Complaint'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SendComplaintPage(title: "Prescription Details",),));
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_score_sharp),
              title: const Text(' View Activity Point '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewActivityPointPage(title: '',),));
              },
            ),
            //

            ListTile(
              leading: Icon(Icons.book),
              title: const Text(' View Booking Status '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBookingStatusPage(title: "View Booking Status",),));
              },

            ),

            ListTile(
              leading: Icon(Icons.event_sharp),
              title: const Text(' View Event Details '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewEventDetailsPage(title: "View Event Details",),));
              },
            ),ListTile(
              leading: Icon(Icons.reply),
              title: const Text(' View Reply'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: 'View Reply',),));
              },
            ),ListTile(
              leading: Icon(Icons.event),
              title: const Text(' View Nearest Event'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => nearestevent(title: 'View Nearest Event',),));
              },
            ),

            ListTile(
              leading: Icon(Icons.point_of_sale),
              title: const Text('Set Activity Point'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => set_activity_point(title: 'Set Activity Point',),));
              },
            ),
 ListTile(
              leading: Icon(Icons.point_of_sale),
              title: const Text('View Total Activity Point'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTotalActivityPoint(title: 'View Total Activity Point',),));
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage(title: 'Login',),));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          HomeBackgroundColor(opacity),
          SingleChildScrollView(
            controller: scrollController,
            padding:  EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  // onTap: () =>Scaffold.of(context).openDrawer(),
                  onTap: () {

                    _scaffoldKey.currentState?.openDrawer();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawer()));
                  },
                  child: Icon(Icons.menu, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child:  TextField(
                    onChanged: (value) => ViewEventDetails(value),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                ),
              ],
            ),
          ),
                UIHelper.verticalSpace(16),
                buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: HomePageButtonNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //     // Scaffold.of(context).openDrawer();
      //
      //
      //     _scaffoldKey.currentState?.openDrawer();
      //
      //   },
      //   child: const Icon(FontAwesomeIcons.qrcode),
      // ),
    );
  }





  Widget buildSearchAppBar() {
    const inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            // onTap: () =>Scaffold.of(context).openDrawer(),
            onTap: () {

              _scaffoldKey.currentState?.openDrawer();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Drawer()));
            },
            child: Icon(Icons.menu, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildSearchAppBar() {
  //   const inputBorder = UnderlineInputBorder(
  //     borderSide: BorderSide(color: Colors.white),
  //   );
  //   return const Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: TextField(
  //       style: TextStyle(color: Colors.white),
  //       decoration: InputDecoration(
  //         hintText: "Search...",
  //         hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
  //         border: inputBorder,
  //         enabledBorder: inputBorder,
  //         focusedBorder: inputBorder,
  //       ),
  //     ),
  //   );
  // }

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upcoming Events",
            style: headerStyle.copyWith(color: Colors.white),
          ),
          UIHelper.verticalSpace(16),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: poster_.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = poster_[index];
                return UpComingEventCard(
                  onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(),));
                },
                  photo: poster_[index], date: date_[index],
                  eventname: event_name_[index], id: id_[index],

                  // duration: duration_[index],
                  // venue: venue_[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }



Widget buildNearbyConcerts() {
    return Container(
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding:  EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Text("Nearby Events", style: headerStyle),
               Spacer(),
               Icon(Icons.more_horiz),
              UIHelper.horizontalSpace(16),
            ],
          ),


          Container(
            height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: nid_.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        Text(
                          nevent_name_[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Image with Rounded Corners
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            nposter_[index],
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 140,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Event Details
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red, size: 20),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "${nvenue_[index]}, ${nCollege_name_[index]}",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.blueAccent, size: 18),
                            SizedBox(width: 6),
                            Text(
                              ndate_[index],
                              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                            ),
                            Spacer(),
                            Icon(Icons.timer, color: Colors.orange, size: 18),
                            SizedBox(width: 6),
                            Text(
                              "${nduration_[index]} hrs",
                              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Price & Points
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "🎟️ ${npoint_[index]} Points",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),
                            ),
                            Text(
                              "💰 ₹${namount_[index]}",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Book Now Button (Gradient Button)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () async {
                              SharedPreferences sh = await SharedPreferences.getInstance();
                              String url = sh.getString('url') ?? "";
                              String lid = sh.getString('lid') ?? "";

                              final urls = Uri.parse('$url/myapp/std_bookevents/');
                              try {
                                final response = await http.post(urls, body: {
                                  'eid': id_[index],
                                  'lid': lid,
                                });

                                if (response.statusCode == 200) {
                                  String status = jsonDecode(response.body)['status'];
                                  Fluttertoast.showToast(
                                    msg: status == 'ok' ? 'Booked Successfully' : 'Booking Failed',
                                  );
                                  if (status == 'ok') {
                                    Fluttertoast.showToast(
                                      msg: status == 'ok' ? 'Booked Successfully' : 'Booking success',
                                    );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => nearestevent(title: '')),
                                    // );
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: 'Network Error');
                                }
                              } catch (e) {
                                Fluttertoast.showToast(msg: "Error: ${e.toString()}");
                              }
                            },
                            child: Text("Book Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
            ,
            // child: ListView.builder(
            //   physics: BouncingScrollPhysics(),
            //   // padding: EdgeInsets.all(5.0),
            //   // shrinkWrap: true,
            //   itemCount: nid_.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       onLongPress: () {
            //         print("long press" + index.toString());
            //       },
            //       title: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Card(
            //                 child:
            //                 Row(
            //                     children: [
            //                       Column(
            //                         children: [
            //
            //                           Image(image: NetworkImage(nposter_[index]),height: 80,width: 80,),
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(ndate_[index]),
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(nevent_name_[index]),
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(nvenue_[index]),
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(nCollege_name_[index]),
            //                           ),
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(nduration_[index]),
            //                           ),
            //
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(npoint_[index]),
            //                           ),
            //
            //                           Padding(
            //                             padding: EdgeInsets.all(5),
            //                             child: Text(namount_[index]),
            //                           ),
            //
            //                           ElevatedButton(
            //                             onPressed: () async {
            //
            //
            //
            //                               SharedPreferences sh = await SharedPreferences.getInstance();
            //                               String url = sh.getString('url').toString();
            //                               String lid = sh.getString('lid').toString();
            //
            //                               final urls = Uri.parse('$url/myapp/std_bookevents/');
            //                               try {
            //                                 final response = await http.post(urls, body: {
            //                                   'eid':id_[index],
            //                                   'lid':lid,
            //
            //                                 });
            //                                 if (response.statusCode == 200) {
            //                                   String status = jsonDecode(response.body)['status'];
            //                                   if (status=='ok') {
            //                                     Fluttertoast.showToast(msg: 'Book Successfully');
            //                                     Navigator.push(
            //                                         context,
            //                                         MaterialPageRoute(builder: (context) => nearestevent(title: '',)));
            //                                   }else {
            //                                     Fluttertoast.showToast(msg: 'Send Failed');
            //                                   }
            //                                 }
            //                                 else {
            //                                   Fluttertoast.showToast(msg: 'Network Error');
            //                                 }
            //                               }
            //                               catch (e){
            //                                 Fluttertoast.showToast(msg: e.toString());
            //                               }
            //
            //
            //
            //                             },
            //                             child: Text("Book"),
            //                           ),
            //
            //                         ],
            //                       ),
            //
            //                     ]
            //                 ),
            //
            //                 elevation: 8,
            //                 margin: EdgeInsets.all(10),
            //               ),
            //             ],
            //           )),
            //     );
            //   },
            // ),

          ),
          // ListView.builder(
          //   itemCount: nearbyEvents.length,
          //   shrinkWrap: true,
          //   primary: false,
          //   itemBuilder: (context, index) {
          //     final event = nearbyEvents[index];
          //     var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
          //       CurvedAnimation(
          //         parent: controller,
          //         curve: Interval((1 / nearbyEvents.length) * index, 1.0, curve: Curves.decelerate),
          //       ),
          //     );
          //     return AnimatedBuilder(
          //       animation: animation,
          //       builder: (context, child) => Transform.translate(
          //         offset: Offset(animation.value, 0.0),
          //         child: NearbyEventCard(
          //           event: event,
          //           onTap: () => viewEventDetail(event),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }


}
