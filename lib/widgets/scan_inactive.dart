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
      children: [
        Text("Scanning is off"),
        Text("Tap the icon below to start scanning")
      ],
    ));
  }
}
