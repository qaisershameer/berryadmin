import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:berryadmin/pages/trips_page.dart';
import 'package:berryadmin/pages/users_page.dart';
import 'package:berryadmin/pages/drivers_page.dart';
import 'package:berryadmin/pages/dash_board_page.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  Widget chosenScreen = DashBoardPage();
  String selectedRoute = DriversPage.id;

  int index = 0;

  List<String> pageRoutes = [DriversPage.id, UsersPage.id, TripsPage.id];

  /// On Click Menu Navigate To Selected Page
  navigateTo(selectedPage){
    switch(selectedPage.route){

      /// Drivers Page
      case DriversPage.id:
        setState(() {
          chosenScreen = DriversPage();
          index = 0;
        });
        break;

      /// Users Page
      case UsersPage.id:
        setState(() {
          chosenScreen = UsersPage();
          index = 1;
        });
        break;

      /// Trips Page
      case TripsPage.id:
        setState(() {
          chosenScreen = TripsPage();
          index = 2;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(

      key: ValueKey(index),

      ///--- [AppBar] ---
      appBar: AppBar(
        backgroundColor: Colors.green,

        ///--- AppBar Title
        title: Text('Berries Admin Panel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      ///--- [SideBar] ---
      sideBar: SideBar(
        activeIconColor: Colors.green,
        activeTextStyle: TextStyle(color: Colors.green),
        iconColor: Colors.grey.shade700,
        textStyle: TextStyle(color: Colors.grey.shade700),

        ///--- [Header]
        header: Container(
          height: 72,
          color: Colors.green.shade600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ///--- Header Icon
              Icon(Icons.admin_panel_settings, color: Colors.white, size: 70),
            ],
          ),
        ),

        ///--- [Footer]
        footer: Container(
          height: 50,
          color: Colors.green.shade600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ///--- Footer Icon
              Icon(Icons.copyright, color: Colors.white, size: 20),

              ///--- Footer Gap
              SizedBox(width: 8),

              ///--- Footer Title
              Text(
                'NexusBerry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        items: [

          ///--- Drivers Menu
          AdminMenuItem(
            title: 'App Drivers',
            route: DriversPage.id,
            icon: CupertinoIcons.car_detailed,
          ),

          ///--- Users Menu
          AdminMenuItem(
            title: 'App Users',
            route: UsersPage.id,
            icon: Icons.supervised_user_circle,
          ),

          ///--- Trips Menu
          AdminMenuItem(
            title: 'Trips',
            route: TripsPage.id,
            icon: CupertinoIcons.location_circle,
          )

        ],

        ///--- [Selected Routes] ---
        onSelected:(item) {
          navigateTo(item);
        },
        selectedRoute: pageRoutes[index],
      ),

      ///--- [Chosen Screen] ---
      body: chosenScreen,
    );
  }
}
