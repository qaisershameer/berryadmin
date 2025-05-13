import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:berryadmin/utils/q_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../utils/q_colors.dart';

class UsersData extends StatefulWidget {
  const UsersData({super.key});

  @override
  State<UsersData> createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  final usersRefFromDB = FirebaseDatabase.instance.ref().child(QConst.userCollection);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: usersRefFromDB.onValue,
        builder: (context, snapshotData) {

          /// if Error loading data
          if (snapshotData.hasError) {
            return Center(child: Text('Error Occurred Users Collection, try later...'));
          }

          /// if snapshot data is on waiting
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: QColors.primary));
          }

          /// Check if data is null
          final dataSnapshot = snapshotData.data?.snapshot;
          if (dataSnapshot == null || dataSnapshot.value == null) {
            return Center(child: Text('No users found.'));
          }

          /// Extract Data from Firebase DB
          Map userDataMap = snapshotData.data!.snapshot.value as Map;
          List usersList =[];

          /// loop data and add data in Users List
          userDataMap.forEach((key, value) => usersList.add({'key': key, ...value}));

          /// display data for UI
          return ListView.builder(
              shrinkWrap: true,
              itemCount: usersList.length,
              itemBuilder: (context, index) {

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                      children: [

                        /// Data Detail Fields
                        QWidgets.dataContainer(colWidth: 250, widget: Text(usersList[index]['userId'].toString())),
                        QWidgets.dataContainer(colWidth: 100, widget: ImageNetwork(image: usersList[index]['photo'].toString(), height: 70, width: 70)),
                        QWidgets.dataContainer(colWidth: 120, widget: Text(usersList[index]['name'].toString())),
                        QWidgets.dataContainer(colWidth: 200, widget: Text(usersList[index]['email'].toString())),
                        QWidgets.dataContainer(colWidth: 120, widget: Text(usersList[index]['phone'].toString())),
                        QWidgets.dataContainer(colWidth: 150, widget: usersList[index]['payments'] != null ? Text(usersList[index]['payments'].toString()) : Text('\$ 0')),

                        /// Widget Action Buttons
                        QWidgets.dataContainer(colWidth: 300, widget:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            usersList[index]['blockStatus'] == 'no'
                            /// Block Button
                                ? ElevatedButton(onPressed: () async {await usersRefFromDB.child(usersList[index]['key']).update({'blockStatus': 'yes'});},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: Text('Block', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))

                            /// Approve Button
                                : ElevatedButton(onPressed: () async {await usersRefFromDB.child(usersList[index]['key']).update({'blockStatus': 'no'});},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: Text('Approve', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),

                            /// Buttons Gap
                            SizedBox(width: 8.0),

                            /// Delete Button
                            ElevatedButton(onPressed: () async {
                              /// Delete Confirmation
                              bool confirmDel = await _showAlertDialog(context);
                              if(confirmDel){
                                await usersRefFromDB.child(usersList[index]['userId']).remove();
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