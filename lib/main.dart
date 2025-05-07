import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:berryadmin/side_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  /// For Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize App
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
        if (kDebugMode) {
          print('Connected =====> Firebase Configured Successfully.');
        }
      })
      .onError((error, stackTrace) {
        if (kDebugMode) {
          print('Error =====> Firebase is Not Configured Successfully.');
          print('Error =====> $error');
        }
      });

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berry Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: SideNavBar(),
    );
  }
}
