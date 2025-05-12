import 'package:flutter/material.dart';
import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:berryadmin/pages/widgets/trips_data.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});
  static const String id = '\webPageTrips';
  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
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
                  'Manage Trips Detail',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    /// Headings with Fixed Column Widths
                    QWidgets.headerContainer(colWidth: 250, headerTitle: 'RIDE ID'),
                    QWidgets.headerContainer(colWidth: 150, headerTitle: 'USER NAME'),
                    QWidgets.headerContainer(colWidth: 150, headerTitle: 'DRIVER NAME',),
                    QWidgets.headerContainer(colWidth: 200, headerTitle: 'CAR DETAILS'),
                    QWidgets.headerContainer(colWidth: 150, headerTitle: 'TIMING'),
                    QWidgets.headerContainer(colWidth: 120, headerTitle: 'FARE'),
                    QWidgets.headerContainer(colWidth: 250, headerTitle: 'ACTIONS'),
                  ],
                ),
              ),

              /// Trips Data from Firestore DB
              // Expanded(child: TripsData()),
            ],
          ),
        ),
      ),
    );
  }
}
