import 'package:flutter/material.dart';

class QWidgets {

  final qWidgets = QWidgets._();
  QWidgets._();

  ///--- [Header Container] ---
  static Widget headerContainer({
    required double colWidth,
    required String headerTitle,
  }) {
    return Container(
      height: 50,
      width: colWidth,
      alignment: Alignment.center,

      /// Header Container Box Decoration
      decoration: BoxDecoration(
        // color: Color.fromARGB(100, 18, 37, 18),
        color: Colors.green,
        border: Border.all(color: Colors.black),
      ),

      /// Title Padding
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),

        /// Title
        child: Text(
          headerTitle,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  ///--- [Detail Data Container] ---
  static Widget dataContainer({
    required double colWidth,
    required Widget widget,
  }) {
    return Container(
      height: 70,
      width: colWidth,
      alignment: Alignment.center,

      /// Header Container Box Decoration
      decoration: BoxDecoration(
        // color: Color.fromARGB(100, 18, 37, 18),
        color: Colors.green,
        border: Border.all(color: Colors.black),
      ),

      /// Title Padding
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),

        /// Title
        child: widget

        // Text(
        //   dataTitle,
        //   textAlign: TextAlign.center,
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        // ),

      ),
    );
  }
}
