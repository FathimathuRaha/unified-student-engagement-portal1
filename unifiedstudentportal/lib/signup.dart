
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'package:unifiedstudentportal/login.dart';
import 'package:unifiedstudentportal/logindesign.dart';


void main() {
  runApp(const MyMySignup());
}

class MyMySignup extends StatelessWidget {
  const MyMySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMySignupPage(title: 'MySignup'),
    );
  }
}

class MyMySignupPage extends StatefulWidget {
  const MyMySignupPage({super.key, required this.title});

  final String title;

  @override
  State<MyMySignupPage> createState() => _MyMySignupPageState();
}

class _MyMySignupPageState extends State<MyMySignupPage> {

  String gender = "Male";
  File? uploadimage;
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
  TextEditingController passwordController= new TextEditingController();
  TextEditingController confirmpasswordController= new TextEditingController();


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
                      Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
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


              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm Password")),
                ),
              ),

              ElevatedButton(
                onPressed: () {

                  _send_data() ;

                },
                child: Text("Signup"),
              ),

              TextButton(
                onPressed: () {},
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _send_data() async{

    String uname=nameController.text;
    String uemail=emailController.text;
    String uphone=phoneController.text;
    String udob=dobController.text;
    String uplace=placeController.text;
    String upost=postController.text;
    String upin=pinController.text;
    String udistrict=districtController.text;
    String ucollegename=collegenameController.text;
    String ucourse=courseController.text;
    String udepartment=departmentController.text;
    String usemester=semesterController.text;
    String upassword=passwordController.text;
    String uconfirmpassword=confirmpasswordController.text;
    String photos=photo;
    String genders=gender;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/std_register/');
    try {

      final response = await http.post(urls, body: {
        "photo":photos,
        "gender":genders,
        "name":uname,
        "email":uemail,
        "phone":uphone,
        "dob":udob,
        "place":uplace,
        "post":upost,
        "pin":upin,
        "district":udistrict,
        "college_name":ucollegename,
        "course":ucourse,
        "department":udepartment,
        "semester":usemester,
        "password":upassword,
        "confirm_password":uconfirmpassword,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Registration Successfull');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyLoginPage(title: "Login"),));
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
