//
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart ';
//
// import 'package:permission_handler/permission_handler.dart';
// import 'package:unifiedstudentportal/login.dart';
// import 'package:unifiedstudentportal/logindesign.dart';
//
//
// void main() {
//   runApp(const MyMySignup());
// }
//
// class MyMySignup extends StatelessWidget {
//   const MyMySignup({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MySignup',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyMySignupPage(title: 'MySignup'),
//     );
//   }
// }
//
// class MyMySignupPage extends StatefulWidget {
//   const MyMySignupPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyMySignupPage> createState() => _MyMySignupPageState();
// }
//
// class _MyMySignupPageState extends State<MyMySignupPage> {
//
//   String gender = "Male";
//   File? uploadimage;
//   TextEditingController nameController= new TextEditingController();
//   TextEditingController emailController= new TextEditingController();
//   TextEditingController phoneController= new TextEditingController();
//   TextEditingController dobController= new TextEditingController();
//   TextEditingController placeController= new TextEditingController();
//   TextEditingController postController= new TextEditingController();
//   TextEditingController pinController= new TextEditingController();
//   TextEditingController districtController= new TextEditingController();
//   TextEditingController collegenameController= new TextEditingController();
//   TextEditingController courseController= new TextEditingController();
//   TextEditingController departmentController= new TextEditingController();
//   TextEditingController semesterController= new TextEditingController();
//   TextEditingController passwordController= new TextEditingController();
//   TextEditingController confirmpasswordController= new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   children: [
//                     Text('Seminar & workshop(ktu-1 :)'),
//                     if (_selectedImage1 != null) ...{
//                       InkWell(
//                         child:
//                         Image.file(_selectedImage1!, height: 150,),
//                         radius: 100,
//                         onTap: _checkPermissionAndChooseImage1,
//                         // borderRadius: BorderRadius.all(Radius.circular(200)),
//                       ),
//                     } else ...{
//                       // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                       InkWell(
//                         onTap: _checkPermissionAndChooseImage1,
//                         child:Column(
//                           children: [
//                             Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                             Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                           ],
//                         ),
//                       ),
//                     },
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   children: [
//                     Text('Seminar & workshop(ktu-2 :)'),
//                     if (_selectedImage2 != null) ...{
//                       InkWell(
//                         child:
//                         Image.file(_selectedImage2!, height: 150,),
//                         radius: 100,
//                         onTap: _checkPermissionAndChooseImage2,
//                         // borderRadius: BorderRadius.all(Radius.circular(200)),
//                       ),
//                     } else ...{
//                       // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                       InkWell(
//                         onTap: _checkPermissionAndChooseImage2,
//                         child:Column(
//                           children: [
//                             Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                             Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                           ],
//                         ),
//                       ),
//                     },
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Seminar & workshop(NIT/IIT-1 :)'),
//                         if (_selectedImage3 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage3!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage3,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage3,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//                       ],
//
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   children: [
//                     Text('Seminar & workshop(NIT/IIT-2 :)'),
//                     if (_selectedImage4 != null) ...{
//                       InkWell(
//                         child:
//                         Image.file(_selectedImage4!, height: 150,),
//                         radius: 100,
//                         onTap: _checkPermissionAndChooseImage4,
//                         // borderRadius: BorderRadius.all(Radius.circular(200)),
//                       ),
//                     } else ...{
//                       // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                       InkWell(
//                         onTap: _checkPermissionAndChooseImage4,
//                         child:Column(
//                           children: [
//                             Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                             Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                           ],
//                         ),
//                       ),
//                     },
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Poster Presentation(ktu-1 :)'),
//                         if (_selectedImage5 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage5!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage5,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage5,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//                       ],
//
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Poster Presentation(ktu-2 :)'),
//                         if (_selectedImage6 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage6!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage6,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage6,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//                       ],
//
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Poster Presentation(NIT/IIT-1 :)'),
//                         if (_selectedImage7 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage7!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage7,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage7,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//                       ],
//
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Poster Presentation(NIT/IIT-2 :)'),
//                         if (_selectedImage8 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage8!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage8,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage8,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//                       ],
//
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//                         Text('Internship(ktu-1 :)'),
//                         if (_selectedImage9 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage9!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage9,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage9,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-1 :)'),
//                         if (_selectedImage10 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage10!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage10,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage10,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-2 :)'),
//                         if (_selectedImage11 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage11!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage11,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage11,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-3 :)'),
//                         if (_selectedImage12 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage12!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage12,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage12,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-4 :)'),
//                         if (_selectedImage13 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage13!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage13,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage13,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-5 :)'),
//                         if (_selectedImage14 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage14!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage14,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage14,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-6 :)'),
//                         if (_selectedImage15 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage15!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage15,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage15,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//
//                         Text('Sports(ktu-7 :)'),
//                         if (_selectedImage16 != null) ...{
//                           InkWell(
//                             child:
//                             Image.file(_selectedImage16!, height: 150,),
//                             radius: 100,
//                             onTap: _checkPermissionAndChooseImage16,
//                             // borderRadius: BorderRadius.all(Radius.circular(200)),
//                           ),
//                         } else ...{
//                           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                           InkWell(
//                             onTap: _checkPermissionAndChooseImage16,
//                             child:Column(
//                               children: [
//                                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
//                                 Text('Select Certificate',style: TextStyle(color: Colors.cyan))
//                               ],
//                             ),
//                           ),
//                         },
//
//                   ],
//                 )
//
//               ),
//
//
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: emailController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
//               //   ),
//               // ),
//               //
//               // RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
//               // RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
//               // RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
//
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: phoneController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: dobController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Dob")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: placeController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: postController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Post")),
//               //   ),
//               // ),
//               //
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: pinController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Pin")),
//               //   ),
//               // ),
//               //
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: districtController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("District")),
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: collegenameController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("College Name")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: courseController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Course")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: departmentController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Department")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: semesterController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Semester")),
//               //   ),
//               // ),
//               //
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: passwordController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(8),
//               //   child: TextField(
//               //     controller: confirmpasswordController,
//               //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm Password")),
//               //   ),
//               // ),
//
//               ElevatedButton(
//                 onPressed: () {
//
//                   _send_data() ;
//
//                 },
//                 child: Text("Signup"),
//               ),
//
//               // TextButton(
//               //   onPressed: () {},
//               //   child: Text("Login"),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _send_data() async{
//
//     // String uname=nameController.text;
//     // String uemail=emailController.text;
//     // String uphone=phoneController.text;
//     // String udob=dobController.text;
//     // String uplace=placeController.text;
//     // String upost=postController.text;
//     // String upin=pinController.text;
//     // String udistrict=districtController.text;
//     // String ucollegename=collegenameController.text;
//     // String ucourse=courseController.text;
//     // String udepartment=departmentController.text;
//     // String usemester=semesterController.text;
//     // String upassword=passwordController.text;
//     // String uconfirmpassword=confirmpasswordController.text;
//     String photos1=photo1;
//     String photos2=photo2;
//     String photos3=photo3;
//     String photos4=photo4;
//     String photos5=photo5;
//     String photos6=photo6;
//     String photos7=photo7;
//     String photos8=photo8;
//     String photos9=photo9;
//     String photos10=photo10;
//     String photos11=photo11;
//     String photos12=photo12;
//     String photos13=photo13;
//     String photos14=photo14;
//     String photos15=photo15;
//     String photos16=photo16;
//     // String genders=gender;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/myapp/std_register/');
//     try {
//
//       final response = await http.post(urls, body: {
//         "photo":photos1,
//         // "gender":genders,
//         // "name":uname,
//         // "email":uemail,
//         // "phone":uphone,
//         // "dob":udob,
//         // "place":uplace,
//         // "post":upost,
//         // "pin":upin,
//         // "district":udistrict,
//         // "college_name":ucollegename,
//         // "course":ucourse,
//         // "department":udepartment,
//         // "semester":usemester,
//         // "password":upassword,
//         // "confirm_password":uconfirmpassword,
//
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           Fluttertoast.showToast(msg: 'Registration Successfull');
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => MyLoginPage(title: "Login"),));
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
//   File? _selectedImage1;
//   File? _selectedImage2;
//   File? _selectedImage3;
//   File? _selectedImage4;
//   File? _selectedImage5;
//   File? _selectedImage6;
//   File? _selectedImage7;
//   File? _selectedImage8;
//   File? _selectedImage9;
//   File? _selectedImage10;
//   File? _selectedImage11;
//   File? _selectedImage12;
//   File? _selectedImage13;
//   File? _selectedImage14;
//   File? _selectedImage15;
//   File? _selectedImage16;
//
//   String? _encodedImage1;
//   String? _encodedImage2;
//   String? _encodedImage3;
//   String? _encodedImage4;
//   String? _encodedImage5;
//   String? _encodedImage6;
//   String? _encodedImage7;
//   String? _encodedImage8;
//   String? _encodedImage9;
//   String? _encodedImage10;
//   String? _encodedImage11;
//   String? _encodedImage12;
//   String? _encodedImage13;
//   String? _encodedImage14;
//   String? _encodedImage15;
//   String? _encodedImage16;
//   Future<void> _chooseAndUploadImage1() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage1 = File(pickedImage.path);
//         _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
//         photo1 = _encodedImage1.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage2() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage2 = File(pickedImage.path);
//         _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
//         photo1 = _encodedImage2.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage3() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage3 = File(pickedImage.path);
//         _encodedImage3 = base64Encode(_selectedImage3!.readAsBytesSync());
//         photo1 = _encodedImage3.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage4() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage4 = File(pickedImage.path);
//         _encodedImage4 = base64Encode(_selectedImage4!.readAsBytesSync());
//         photo1 = _encodedImage4.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage5() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage5 = File(pickedImage.path);
//         _encodedImage5 = base64Encode(_selectedImage5!.readAsBytesSync());
//         photo1 = _encodedImage5.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage6() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage6 = File(pickedImage.path);
//         _encodedImage6 = base64Encode(_selectedImage6!.readAsBytesSync());
//         photo1 = _encodedImage6.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage7() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage7 = File(pickedImage.path);
//         _encodedImage7 = base64Encode(_selectedImage7!.readAsBytesSync());
//         photo1 = _encodedImage7.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage8() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage8 = File(pickedImage.path);
//         _encodedImage8 = base64Encode(_selectedImage8!.readAsBytesSync());
//         photo1 = _encodedImage8.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage9() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage9 = File(pickedImage.path);
//         _encodedImage9 = base64Encode(_selectedImage9!.readAsBytesSync());
//         photo1 = _encodedImage9.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage10() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage10 = File(pickedImage.path);
//         _encodedImage10 = base64Encode(_selectedImage10!.readAsBytesSync());
//         photo1 = _encodedImage10.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage11() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage11 = File(pickedImage.path);
//         _encodedImage11 = base64Encode(_selectedImage11!.readAsBytesSync());
//         photo1 = _encodedImage11.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage12() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage12 = File(pickedImage.path);
//         _encodedImage12 = base64Encode(_selectedImage12!.readAsBytesSync());
//         photo1 = _encodedImage12.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage13() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage13 = File(pickedImage.path);
//         _encodedImage13 = base64Encode(_selectedImage13!.readAsBytesSync());
//         photo1 = _encodedImage13.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage14() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage14 = File(pickedImage.path);
//         _encodedImage14 = base64Encode(_selectedImage14!.readAsBytesSync());
//         photo1 = _encodedImage14.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage15() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage15 = File(pickedImage.path);
//         _encodedImage15 = base64Encode(_selectedImage15!.readAsBytesSync());
//         photo1 = _encodedImage15.toString();
//       });
//     }
//   }
//   Future<void> _chooseAndUploadImage16() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage16 = File(pickedImage.path);
//         _encodedImage16 = base64Encode(_selectedImage16!.readAsBytesSync());
//         photo1 = _encodedImage16.toString();
//       });
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//   //   final picker = ImagePicker();
//   //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//   //
//   //   if (pickedImage != null) {
//   //     setState(() {
//   //       _selectedImage = File(pickedImage.path);
//   //       _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
//   //       photo1 = _encodedImage.toString();
//   //     });
//   //   }
//   // }
//
//   Future<void> _checkPermissionAndChooseImage1() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//   Future<void> _checkPermissionAndChooseImage2() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage3() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage4() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage5() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage6() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage7() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage8() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage9() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage10() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage11() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage12() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage13() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage14() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage15() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   Future<void> _checkPermissionAndChooseImage16() async {
//   final PermissionStatus status = await Permission.mediaLibrary.request();
//   if (status.isGranted) {
//     _chooseAndUploadImage();
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text(
//           'Please go to app settings and grant permission to choose an image.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// String photo1 = '';
//   String photo2 = '';
//   String photo3 = '';
//   String photo4 = '';
//   String photo5 = '';
//   String photo6 = '';
//   String photo7 = '';
//   String photo8 = '';
//   String photo9 = '';
//   String photo10 = '';
//   String photo11 = '';
//   String photo12 = '';
//   String photo13 = '';
//   String photo14 = '';
//   String photo15 = '';
//   String photo16 = '';
//
// }
