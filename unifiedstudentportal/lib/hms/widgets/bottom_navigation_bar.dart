import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unifiedstudentportal/viewnotification.dart';
import 'package:unifiedstudentportal/viewprofile.dart';
import 'package:unifiedstudentportal/viewticket.dart';

class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomePageButtonNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        print(value);
        if(value==1)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotificationpage(title: "View Notification",),));

          }
        if(value==2)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTicketPage(title: "View Ticket",),));

        }
        if(value==3)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: 'View Profile',),));

        }


      },
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "Notification",
          icon: Icon(Icons.notification_add),
        ),
        BottomNavigationBarItem(
          label: "Ticket",
          icon: Icon(FontAwesomeIcons.ticketAlt),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
