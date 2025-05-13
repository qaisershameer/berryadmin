import 'package:get/get.dart';
import '../pages/users/users_page.dart';
import '../pages/drivers/drivers_page.dart';
import '../pages/trips/trips_page.dart';
import '../pages/dash_board_page.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/users_binding.dart';
import '../bindings/drivers_binding.dart';
import '../bindings/trips_binding.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String users = '/users';
  static const String drivers = '/drivers';
  static const String trips = '/trips';

  static final routes = [
    GetPage(
      name: dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: users,
      page: () => const UsersPage(),
      binding: UsersBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: drivers,
      page: () => const DriversPage(),
      binding: DriversBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: trips,
      page: () => const TripsPage(),
      binding: TripsBinding(),
      transition: Transition.fadeIn,
    ),
  ];
} 