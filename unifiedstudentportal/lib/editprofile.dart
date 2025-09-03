

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'package:unifiedstudentportal/viewprofile.dart';


void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyEditPage(title: 'Edit Profile'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {

  _MyEditPageState()
  {
    _get_data();
  }

  String gender = "Male";
  String upic = "";
  TextEditingController nameController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController dobController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  TextEditingController collegenameController= new TextEditingController();
  TextEditingController courseController= new TextEditingController();
  TextEditingController departmentController= new TextEditingController();
  TextEditingController semesterController= new TextEditingController();


  void _get_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/myapp/std_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'].toString();
          String dob=jsonDecode(response.body)['dob'].toString();
          String gender_=jsonDecode(response.body)['gender'].toString();
          String email=jsonDecode(response.body)['email'].toString();
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'].toString();
          String post=jsonDecode(response.body)['post'].toString();
          String pin=jsonDecode(response.body)['pin'].toString();
          String district=jsonDecode(response.body)['district'].toString();
          String collegename=jsonDecode(response.body)['college_name'].toString();
          String course=jsonDecode(response.body)['course'].toString();
          String department=jsonDecode(response.body)['department'].toString();
          String semester=jsonDecode(response.body)['semester'].toString();
          String photo=img_url+jsonDecode(response.body)['photo'];

          setState(() {

            nameController.text= name;
            dobController.text= dob;
            gender= gender_;
            emailController.text= email;
            phoneController.text= phone;
            placeController.text= place;
            postController.text= post;
            pinController.text= pin;
            districtController.text= district;
            collegenameController.text= collegename;
            courseController.text=course;
            departmentController.text= department;
            semesterController.text= semester;
            upic= photo;
          });





        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {




    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              if (_selectedImage != null) ...{
                InkWell(
                  child:
                  Image.file(_selectedImage!, height: 400,),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child:Column(
                    children: [
                      Image(image: NetworkImage(upic),height: 200,width: 200,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
                ),
              ),

              RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: dobController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Dob")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: placeController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: postController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Post")),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: pinController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Pin")),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: districtController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("District")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: collegenameController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("College Name")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: courseController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Course")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: departmentController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Department")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: semesterController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Semester")),
                ),
              ),



              ElevatedButton(
                onPressed: () {
                  _send_data();

                },
                child: Text("Confirm Edit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _send_data() async{





    String uname=nameController.text;
    String dob=dobController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String place=placeController.text;
    String post=postController.text;
    String pin=pinController.text;
    String district=districtController.text;
    String collegename=collegenameController.text;
    String course=courseController.text;
    String department=departmentController.text;
    String semester=semesterController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/std_editprofile/');
    try {

      final response = await http.post(urls, body: {
        "photo":photo,
        'name':uname,
        'dob':dob,
        'gender':gender,
        'email':email,
        'phone':phone,
        'place':place,
        'post':post,
        'pin':pin,
        'district':district,
        'college_name':collegename,
        'course':course,
        'department':department,
        'semester':semester,



        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewProfilePage(title: "Profile"),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';

}
