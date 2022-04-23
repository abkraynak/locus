import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../constants/page_titles.dart';
import '../constants/positioning.dart';
import '../models/locations.dart';
import '../widgets/scan_active.dart';
import '../widgets/scan_inactive.dart';

class LocatePage extends StatefulWidget {
  @override
  _LocatePageState createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  bool isScanning = false;

  Locations locs = Locations();
  List<String> _locations = ["Select location"];
  List<String> _zones = ["Select zone"];

  String _selectedLocation = "Select location";
  String _selectedZone = "Select zone";

  String dropdownValue = "Find a location";

  @override
  void initState() {
    _locations = List.from(_locations)..addAll(locs.getLocations());
    super.initState();
  }

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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Paddings.hor, vertical: Paddings.ver),
            child: isScanning
                ? ScanActive(results: flutterBlue.scan(allowDuplicates: true))
                : ScanInactive(),
          ),
          DropdownButton(
            value: _selectedLocation,
            items: _locations.map((String dropdownStringItem) {
              return DropdownMenuItem<String>(
                value: dropdownStringItem,
                child: Text(dropdownStringItem),
              );
            }).toList(),
            onChanged: (value) => _onSelectedLocation(value),
          ),
          DropdownButton(
            value: _selectedZone,
            items: _zones.map((String dropdownStringItem) {
              return DropdownMenuItem<String>(
                value: dropdownStringItem,
                child: Text(dropdownStringItem),
              );
            }).toList(),
            onChanged: (value) => _onSelectedZone(value),
          )
        ],
      ),
    );
  }

  void _onSelectedLocation(String value) {
    setState(() {
      _selectedZone = "Select zone";
      _zones = ["Select zone"];
      _selectedLocation = value;
      _zones = List.from(_zones)..addAll(locs.getZonesByLocation(value));
    });
  }

  void _onSelectedZone(String value) {
    setState(() => _selectedZone = value);
  }
}

bool toggleScan(bool isScanning, FlutterBlue flutterBlue) {
  if (isScanning) {
    flutterBlue.stopScan();
    return false;
  }
  return true;
}
