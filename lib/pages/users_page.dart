import 'package:flutter/material.dart';
import 'package:berryadmin/common_widgets/q_widgets.dart';
import 'package:berryadmin/pages/widgets/users_data.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});
  static const String id = '\webPageUsers';
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
                  'Manage Users',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    /// Headings with Fixed Column Widths
                    QWidgets.headerContainer(colWidth: 250, headerTitle: 'User ID'),
                    QWidgets.headerContainer(colWidth: 100, headerTitle: 'PICTURE'),
                    QWidgets.headerContainer(colWidth: 120, headerTitle: 'NAME',),
                    QWidgets.headerContainer(colWidth: 200, headerTitle: 'EMAIL'),
                    QWidgets.headerContainer(colWidth: 120, headerTitle: 'PHONE'),
                    QWidgets.headerContainer(colWidth: 150, headerTitle: 'PAYMENTS'),
                    QWidgets.headerContainer(colWidth: 300, headerTitle: 'ACTIONS'),
                  ],
                ),
              ),

              /// Users Data from Firestore DB
              // Expanded(child: UsersData()),
            ],
          ),
        ),
      ),
    );
  }
}
