import 'package:url_launcher/url_launcher.dart';

import '../../utils/q_colors.dart';
import 'package:flutter/material.dart';
import 'package:berryadmin/utils/q_const.dart';
import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class TripsData extends StatefulWidget {
  const TripsData({super.key});

  @override
  State<TripsData> createState() => _TripsDataState();
}

class _TripsDataState extends State<TripsData> {
  final tripsRefFromDB = FirebaseDatabase.instance.ref().child(QConst.tripRequestsCollection);

  /// Function to load Google Map using Latitude, Longitude
  launchGoogleMap(pickUpLat, pickUpLong, dropOffLat, dropOffLong) async {
    String directionURL = 'https://www.google.com/maps/dir/?api=1&origin=$pickUpLat,$pickUpLong&destination=$dropOffLat,$dropOffLong&dir_action=navigate';

    if(await canLaunchUrl(Uri.parse(directionURL))){
      await launchUrl(Uri.parse(directionURL));
    } else {
      throw 'Could not launch Google Map URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: tripsRefFromDB.onValue,
        builder: (context, snapshotData) {

          /// if Error loading data
          if (snapshotData.hasError) {
            return Center(child: Text('Error Occurred Trips Collection, try later...'));
          }

          /// if snapshot data is on waiting
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: QColors.primary));
          }

          /// Check if data is null
          final dataSnapshot = snapshotData.data?.snapshot;
          if (dataSnapshot == null || dataSnapshot.value == null) {
            return Center(child: Text('No trips found.'));
          }

          /// Extract Data from Firebase DB
          Map tripsDataMap = snapshotData.data!.snapshot.value as Map;
          List tripsList =[];

          /// loop data and add data in Trips List
          tripsDataMap.forEach((key, value) => tripsList.add({'key': key, ...value}));

          /// display data for UI
          return ListView.builder(
              shrinkWrap: true,
              itemCount: tripsList.length,
              itemBuilder: (context, index) {

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                      children: [

                        /// Data Detail Fields
                        QWidgets.dataContainer(colWidth: 250, widget: Text(tripsList[index]['tripId'].toString())),
                        QWidgets.dataContainer(colWidth: 150, widget: Text(tripsList[index]['user_name'].toString())),
                        QWidgets.dataContainer(colWidth: 150, widget: Text(tripsList[index]['driver_name'].toString())),
                        QWidgets.dataContainer(colWidth: 200, widget: Text(tripsList[index]['car_details']['carModel'].toString())),
                        QWidgets.dataContainer(colWidth: 150, widget: Text(tripsList[index]['timings'].toString())),
                        QWidgets.dataContainer(colWidth: 120, widget: tripsList[index]['fare'] != null ? Text(tripsList[index]['fare'].toString()) : Text('\$ 0')),

                        /// Widget Action Buttons
                        QWidgets.dataContainer(colWidth: 250, widget:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ElevatedButton(onPressed: () async {

                              /// Get Values in Variables from DB
                              String pickUpLat = '30.1014458';    // tripsList[index]['pickUpLatLng']['latitude'];
                              String pickUpLong = '71.3634908';   // tripsList[index]['pickUpLatLng']['longitude'];
                              String dropOffLat = '30.2114123';   // tripsList[index]['dropOffLatLng']['latitude'];
                              String dropOffLong = '71.3950384';  //tripsList[index]['dropOffLatLng']['longitude'];

                              /// Call Google Map Functions
                              launchGoogleMap(pickUpLat, pickUpLong, dropOffLat, dropOffLong);

                            },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: Text('View Map', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),


                            /// Buttons Gap
                            SizedBox(width: 8.0),

                            /// Delete Button
                            ElevatedButton(onPressed: () async {
                              /// Delete Confirmation
                              bool confirmDel = await _showAlertDialog(context);
                              if(confirmDel){
                                await tripsRefFromDB.child(tripsList[index]['tripId']).remove();
                              }
                            },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ],
                        ),
                        )
                      ]
                  ),
                );

              }
          );

        }
    );

  }
}

Future<bool> _showAlertDialog(BuildContext context) async {
  return await showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: const Text('Confirm Deletion!'),
      content: const Text('Are you sure! want to delete this record???'),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: const Text('Cancel')),
        TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: const Text('Delete')),
      ],
    );
  }) ?? false;
}