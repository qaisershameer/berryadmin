import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:berryadmin/utils/q_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../utils/q_colors.dart';

class DriversData extends StatefulWidget {
  const DriversData({super.key});

  @override
  State<DriversData> createState() => _DriversDataState();
}

class _DriversDataState extends State<DriversData> {
  final driversRefFromDB = FirebaseDatabase.instance.ref().child(QConst.driversCollection);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: driversRefFromDB.onValue,
        builder: (context, snapshotData) {

          /// if Error loading data
          if (snapshotData.hasError) {
            return Center(child: Text('Error Occurred Drivers Collection, try later...'));
          }

          /// if snapshot data is on waiting
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: QColors.primary));
          }

          /// Extract Data from Firebase DB
          Map driverDataMap = snapshotData.data!.snapshot.value as Map;
          List driversList =[];

          /// loop data and add data in Drivers List
          driverDataMap.forEach((key, value) => driversList.add({'key': key, ...value}));

          /// display data for UI
          return ListView.builder(
            shrinkWrap: true,
            itemCount: driversList.length,
              itemBuilder: (context, index) {

              return Row(
                  children: [

                    QWidgets.dataContainer(colWidth: 250, widget: Text(driversList[index]['id'].toString())),
                    QWidgets.dataContainer(colWidth: 100, widget: ImageNetwork(image: driversList[index]['photo'].toString(), height: 70, width: 70)),
                    QWidgets.dataContainer(colWidth: 120, widget: Text(driversList[index]['name'].toString())),
                    QWidgets.dataContainer(colWidth: 200, widget: Text(driversList[index]['car_details']['carModel'].toString())),
                    QWidgets.dataContainer(colWidth: 120, widget: Text(driversList[index]['phone'].toString())),
                    QWidgets.dataContainer(colWidth: 150, widget: Text(driversList[index]['earnings'].toString())),
                    QWidgets.dataContainer(colWidth: 300, widget:

                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              driversList[index]['blockStatus'] == 'no'
                                ? ElevatedButton(onPressed: () async {await driversRefFromDB.child(driversList[index]['key']).update({'blockStatus': 'yes'});},
                                  child: Text('Block',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
                                : ElevatedButton(onPressed: () async {await driversRefFromDB.child(driversList[index]['key']).update({'blockStatus': 'no'});},
                                  child: Text('Approve',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
                            ],
                      ),
                    )
                  ]
              );

            }
          );

        }
    );
  }
}

