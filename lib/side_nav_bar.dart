import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'core/app_routes.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Berries Admin Panel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      sideBar: SideBar(
        activeIconColor: Colors.green,
        activeTextStyle: const TextStyle(color: Colors.green),
        iconColor: Colors.grey.shade700,
        textStyle: TextStyle(color: Colors.grey.shade700),
        header: Container(
          height: 72,
          color: Colors.green.shade600,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.admin_panel_settings, color: Colors.white, size: 70),
            ],
          ),
        ),
        footer: Container(
          height: 50,
          color: Colors.green.shade600,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.copyright, color: Colors.white, size: 20),
              SizedBox(width: 8),
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
          AdminMenuItem(
            title: 'Dashboard',
            route: AppRoutes.dashboard,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'App Drivers',
            route: AppRoutes.drivers,
            icon: CupertinoIcons.car_detailed,
          ),
          AdminMenuItem(
            title: 'App Users',
            route: AppRoutes.users,
            icon: Icons.supervised_user_circle,
          ),
          AdminMenuItem(
            title: 'Trips',
            route: AppRoutes.trips,
            icon: CupertinoIcons.location_circle,
          )
        ],
        selectedRoute: Get.currentRoute,
        onSelected: (item) {
          if (item.route != null) {
            Get.toNamed(item.route!);
          }
        },
      ),
      body: Navigator(
        key: Get.nestedKey(1),
        onGenerateRoute: (settings) {
          return GetPageRoute(
            page: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
