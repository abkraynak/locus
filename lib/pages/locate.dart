import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../constants/page_titles.dart';
import '../constants/positioning.dart';
import '../widgets/scan_active.dart';
import '../widgets/scan_inactive.dart';

class LocatePage extends StatefulWidget {
  @override
  _LocatePageState createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    return Scaffold(
        appBar: AppBar(
          title: Text(PageTitles.locate),
        ),
        floatingActionButton: FloatingActionButton(
          child: isScanning
              ? Icon(Icons.portable_wifi_off_outlined)
              : Icon(Icons.wifi_tethering_outlined),
          tooltip: isScanning ? 'Stop Scan' : 'Scan',
          onPressed: () {
            setState(() {
              isScanning = toggleScan(isScanning, flutterBlue);
            });
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.hor, vertical: Paddings.ver),
          child: isScanning
              ? ScanActive(results: flutterBlue.scan(allowDuplicates: true))
              : ScanInactive(),
        ));
  }
}

bool toggleScan(bool isScanning, FlutterBlue flutterBlue) {
  if (isScanning) {
    flutterBlue.stopScan();
    return false;
  }
  return true;
}
