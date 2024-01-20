// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2022  Andrew Kraynak

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
  String _selectedLocation = "Select location";
  List<String> _zones = ["Select zone"];
  String _selectedZone = "Select zone";

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Paddings.logoVer, horizontal: Paddings.logoHor),
                  child: Container(
                    child: Image.asset(_getImagePath()),
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Paddings.hor, vertical: Paddings.ver),
                child: isScanning
                    ? ScanActive(
                    results: flutterBlue.scan(allowDuplicates: true))
                    : ScanInactive(),
              ),
            ],
          ),
        ));
  }

  String _getImagePath() {
    if (_selectedZone == "Select zone") {
      String p = "assets/zones/blank_floor.jpg";
      //print(p);
      return p;
    } else {
      String path =
          "assets/zones/" + _selectedLocation + " " + _selectedZone + ".jpg";
      String res = path.toLowerCase().replaceAll(RegExp(" "), "_");
      //print(res);
      return res;
    }
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
    _getImagePath();
  }
}

bool toggleScan(bool isScanning, FlutterBlue flutterBlue) {
  if (isScanning) {
    flutterBlue.stopScan();
    return false;
  }
  return true;
}
