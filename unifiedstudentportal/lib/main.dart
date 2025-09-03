import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifiedstudentportal/login.dart';
import 'package:unifiedstudentportal/logindesign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void callbackDispatcher(String message) {
    print("hiii");

    // Workmanager().executeTask((task, inputData) {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
    new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip, message);
    // return Future.value(true);
    // });
  }

  Future _showNotificationWithDefaultSound(flip,String message) async {
// Show a notification after every 15 minute with the first
// appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

// initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flip.show(
        0,
        'New event Added',
        message,
        platformChannelSpecifics,
        payload: 'Default_Sound');
  }


  TextEditingController ipController= new TextEditingController();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                // validator:(value)=>Validateip(value!),
                controller: ipController,
                decoration: InputDecoration(border: OutlineInputBorder(),label: Text("ip address")),
              ),
            ),

            ElevatedButton(
              onPressed: () {

                _send_data() ;

              },
              child: Text("Connect"),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> getdata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      // String url = "${sh.getString("url").toString()}/viewNotification/";


      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/myapp/notif/');

      String nid="0";
      if(sh.containsKey("nid")==false) {}
      else{
        nid=sh.getString('nid').toString();
      }
      // Fluttertoast.showToast(msg:nid);

      var datas = await http.post(urls, body: {'nid': nid });
      var jsondata = json.decode(datas.body);
      String status = jsondata['status'];
      print(status);
      if (status == "ok") {
        String nid = jsondata['nid'];
        String message = jsondata['message'];
        sh.setString('nid',nid);
        callbackDispatcher(message);

      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
  void _send_data() async {
    String ip = ipController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("url", "http://" + ip + ":8000");
    sh.setString("img_url", "http://" + ip + ":8000/");

    Timer.periodic(Duration(seconds: 10), (timer) {
      getdata();
    });

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MyLoginPage(title: "Login"),));
  }

 String? Validateip(String value){
    if(value.isEmpty){
      return 'please enter a IP';
    }
    return null;
 }

  }
