import 'package:flutter/material.dart';

class ScanInactive extends StatefulWidget {
  @override
  _ScanInactiveState createState() => _ScanInactiveState();
}

class _ScanInactiveState extends State<ScanInactive> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Scanning is off", textScaleFactor: 1.5),
        Text("Tap the icon below to start scanning")
      ],
    ));
  }
}
