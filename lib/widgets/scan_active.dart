import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../constants/boards.dart';
import '../functions/bluetooth_scanning.dart';
import '../models/device.dart';

class ScanActive extends StatefulWidget {
  Stream<ScanResult> results;
  ScanActive({this.results});

  @override
  _ScanActiveState createState() => _ScanActiveState();
}

class _ScanActiveState extends State<ScanActive> {
  @override
  Widget build(BuildContext context) {
    Stream<ScanResult> results = widget.results;
    List<Device> deviceList = [];

    return Center(
        child: StreamBuilder<ScanResult>(
            stream: results,
            builder: (context, snapshot) {
              if (!snapshot.hasError && snapshot.hasData) {
                var newDevice = true;
                var toRemove = [];
                var signal = new Device(
                    snapshot.data.rssi,
                    snapshot.data.device.id.toString(),
                    snapshot.data.device.name,
                    0);

                //print(snapshot.data.device.id.toString() + snapshot.data.device.name);
                //print(Boards().boardIdentifiers);

                deviceList.forEach((element) {
                  if (element.id == signal.id) {
                    element.addRSSIValue(signal.RSSILast);
                    element.name = signal.name;
                    newDevice = false;
                  } else {
                    element.counter++;
                    if (element.counter > 50) {
                      toRemove.add(element);
                    }
                  }
                });

                deviceList.removeWhere((element) => toRemove.contains(element));

                if (newDevice &&
                    Boards().boardIdentifiers.contains(signal.id)) {
                  deviceList.add(signal);
                }
              }

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    distanceText(getMinDistance(deviceList)),
                    Text('${deviceList.length} devices in range'),
                    ...getDistances(deviceList),
                  ]);
            }));
  }
}

double getMinDistance(List<Device> deviceList) {
  var minDistance = 999.9;
  if (deviceList != null) {
    deviceList.forEach((device) {
      if (device.RSSIAverage != null) {
        var deviceDistance = convertSignalToDistance(device.RSSIAverage);
        if (deviceDistance < minDistance) {
          minDistance = deviceDistance;


        }
      }
    });
  }
  return minDistance;
}

List<Widget> getDistances(List<Device> deviceList) {
  var minDistance = 999.9;
  List<Widget> res = [];
  if (deviceList != null) {
    deviceList.forEach((device) {
      if (device.RSSIAverage != null) {
        var deviceDistance = convertSignalToDistance(device.RSSIAverage);
        var displayDistance = formatDistanceText(deviceDistance);
        var deviceID = device.id;
        var displayID = deviceID.substring(deviceID.length - 4);
        res.add(Text("$displayID : $displayDistance feet away"));

        }
      }
    );
  }
  return res;
}

Text distanceText(double distance) {
  var dist = metersToFeet(distance).toStringAsFixed(2);
  return Text("$dist feet away",
      textScaleFactor: 1.5);
}

String formatDistanceText(double distance){
  return metersToFeet(distance).toStringAsFixed(2);
}
