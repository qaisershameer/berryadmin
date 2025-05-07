import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});
  static const String id = '\webPageDrivers';

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  QWidgets qWidgets = QWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  qWidgets.headerContainer(colWidth: 250, headerTitle: 'DRIVER ID'),
                  qWidgets.headerContainer(colWidth: 100, headerTitle: 'PICTURE'),
                  qWidgets.headerContainer(colWidth: 120, headerTitle: 'NAME'),
                  qWidgets.headerContainer(colWidth: 200, headerTitle: 'CAR DETAILS'),
                  qWidgets.headerContainer(colWidth: 120, headerTitle: 'PHONE'),
                  qWidgets.headerContainer(colWidth: 150, headerTitle: 'EARNINGS'),
                  qWidgets.headerContainer(colWidth: 300, headerTitle: 'ACTIONS'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
