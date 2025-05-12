import 'package:flutter/material.dart';
import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:berryadmin/pages/widgets/drivers_data.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});
  static const String id = '\webPageDrivers';
  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Manage Drivers',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    /// Headings with Fixed Column Widths
                    QWidgets.headerContainer(colWidth: 250, headerTitle: 'DRIVER ID'),
                    QWidgets.headerContainer(colWidth: 100, headerTitle: 'PICTURE'),
                    QWidgets.headerContainer(colWidth: 120, headerTitle: 'NAME',),
                    QWidgets.headerContainer(colWidth: 200, headerTitle: 'CAR DETAILS'),
                    QWidgets.headerContainer(colWidth: 120, headerTitle: 'PHONE'),
                    QWidgets.headerContainer(colWidth: 150, headerTitle: 'EARNINGS'),
                    QWidgets.headerContainer(colWidth: 300, headerTitle: 'ACTIONS'),
                  ],
                ),
              ),

              /// Drivers Data from Firestore DB
              // Expanded(child: DriversData()),
            ],
          ),
        ),
      ),
    );
  }
}
