import 'package:flutter/material.dart';
import 'package:berryadmin/utils/q_images.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(QImages.dashboard),
      ),
    );
  }
}
