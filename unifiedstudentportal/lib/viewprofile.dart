// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'editprofile.dart';
// void main() {
//   runApp(const ViewProfile());
// }
//
// class ViewProfile extends StatelessWidget {
//   const ViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Profile',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ViewProfilePage(title: 'View Profile'),
//     );
//   }
// }
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//
//   _ViewProfilePageState()
//   {
//     _send_data();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton( ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//
//
//               Column(
//                 children: [
//                   Image(image: NetworkImage(photo_),height: 200,width: 200,),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(name_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(dob_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(gender_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(email_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(phone_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(place_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(post_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(pin_),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(district_),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(collegename_),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(course_),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(department_),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text(semester_),
//                   ),
//
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => MyEditPage(title: "Edit Profile"),));
//                 },
//                 child: Text("Edit Profile"),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   String name_="";
//   String dob_="";
//   String gender_="";
//   String email_="";
//   String phone_="";
//   String place_="";
//   String post_="";
//   String pin_="";
//   String district_="";
//   String photo_="";
//   String collegename_="";
//   String course_="";
//   String department_="";
//   String semester_="";
//
//   void _send_data() async{
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String img_url = sh.getString('img_url').toString();
//
//     final urls = Uri.parse('$url/myapp/std_viewprofile/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid':lid
//
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           String name=jsonDecode(response.body)['name'].toString();
//           String dob=jsonDecode(response.body)['dob'].toString();
//           String gender=jsonDecode(response.body)['gender'].toString();
//           String email=jsonDecode(response.body)['email'].toString();
//           String phone=jsonDecode(response.body)['phone'].toString();
//           String place=jsonDecode(response.body)['place'].toString();
//           String post=jsonDecode(response.body)['post'].toString();
//           String pin=jsonDecode(response.body)['pin'].toString();
//           String district=jsonDecode(response.body)['district'].toString();
//           String collegename=jsonDecode(response.body)['college_name'].toString();
//           String course=jsonDecode(response.body)['course'].toString();
//           String department=jsonDecode(response.body)['department'].toString();
//           String semester=jsonDecode(response.body)['semester'].toString();
//           String photo=img_url+jsonDecode(response.body)['photo'];
//
//           setState(() {
//
//             name_= name;
//             dob_= dob;
//             gender_= gender;
//             email_= email;
//             phone_= phone;
//             place_= place;
//             post_= post;
//             pin_= pin;
//             district_= district;
//             collegename_= collegename;
//             course_=course;
//             department_= department;
//             semester_= semester;
//             photo_= photo;
//           });
//
//
//
//
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editprofile.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  _ViewProfilePageState() {
    _send_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Profile Photo
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    photo_,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Profile Details as Card widgets
              _buildProfileCard('Name', name_),
              _buildProfileCard('Date of Birth', dob_),
              _buildProfileCard('Gender', gender_),
              _buildProfileCard('Email', email_),
              _buildProfileCard('Phone', phone_),
              _buildProfileCard('Place', place_),
              _buildProfileCard('Post', post_),
              _buildProfileCard('PIN', pin_),
              _buildProfileCard('District', district_),
              _buildProfileCard('College Name', collegename_),
              _buildProfileCard('Course', course_),
              _buildProfileCard('Department', department_),
              _buildProfileCard('Semester', semester_),

              // Edit Profile Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyEditPage(title: "Edit Profile")),
                    );
                  },
                  child: Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String post_ = "";
  String pin_ = "";
  String district_ = "";
  String photo_ = "";
  String collegename_ = "";
  String course_ = "";
  String department_ = "";
  String semester_ = "";

  // Function to create profile field cards
  Widget _buildProfileCard(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value),
        ),
      ),
    );
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/myapp/std_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'].toString();
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String post = jsonDecode(response.body)['post'].toString();
          String pin = jsonDecode(response.body)['pin'].toString();
          String district = jsonDecode(response.body)['district'].toString();
          String collegename = jsonDecode(response.body)['college_name'].toString();
          String course = jsonDecode(response.body)['course'].toString();
          String department = jsonDecode(response.body)['department'].toString();
          String semester = jsonDecode(response.body)['semester'].toString();
          String photo = img_url + jsonDecode(response.body)['photo'];

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            post_ = post;
            pin_ = pin;
            district_ = district;
            collegename_ = collegename;
            course_ = course;
            department_ = department;
            semester_ = semester;
            photo_ = photo;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
