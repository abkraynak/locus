import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../constants/page_titles.dart';
import '../widgets/locate.dart';

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
          child: Icon(Icons.search),
          tooltip: 'Scan',
          onPressed: () {
            setState(() {
              isScanning = toggleScan(isScanning, flutterBlue);
            });
          },
        ),
        body: Locate());
  }
}

bool toggleScan(bool isScanning, FlutterBlue flutterBlue){
  if(isScanning){
    flutterBlue.stopScan();
    return false;
  }
  flutterBlue.startScan();
  return true;
}