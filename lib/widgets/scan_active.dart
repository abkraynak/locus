import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../constants/boards.dart';
import '../constants/positioning.dart';
import '../functions/bluetooth_scanning.dart';
import '../models/device.dart';
import '../widgets/user_position.dart';

class ScanActive extends StatefulWidget {
  Stream<ScanResult> results;
  ScanActive({this.results});

  @override
  _ScanActiveState createState() => _ScanActiveState();
}

class _ScanActiveState extends State<ScanActive> {
  bool canTriangulate = false;
  bool plural = true;

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
                    element.counter = 0;
                  } else {
                    element.counter++;
                    if (element.counter > 360) {
                      // remove if out of range
                      toRemove.add(element);
                    }
                  }
                });

                deviceList.removeWhere((element) => toRemove.contains(element));

                if (newDevice &&
                    Boards().boardIdentifiers.contains(signal.id)) {
                  switch (signal.id) {
                    case "C3435E79-9EAA-AC23-10F0-DFF9AF523A73":
                      signal.x = 0;
                      signal.y = 0;
                      break;

                    case "5217B9DA-12F1-5EF6-0FAA-95D9727F5C95":
                      signal.x = 5;
                      signal.y = 15;
                      break;

                    case "6436B5C8-37D8-BA76-4471-6CEA27993023":
                      signal.x = 20;
                      signal.y = 9;
                      break;

                    default:
                      signal.x = 0;
                      signal.y = 0;
                      break;
                  }

                  deviceList.add(signal);
                }
                if (deviceList.length == 3) {
                  canTriangulate = true;
                } else {
                  canTriangulate = false;
                }

                if (deviceList.length == 1) {
                  plural = false;
                } else {
                  plural = true;
                }
              }

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //distanceText(getMinDistance(deviceList)),
                    plural
                        ? Text(
                            "${deviceList.length} devices in range",
                            textScaleFactor: 1.5,
                          )
                        : Text(
                            "${deviceList.length} device in range",
                            textScaleFactor: 1.5,
                          ),
                    ...getDistances(deviceList),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          canTriangulate
                              ? UserPosition(
                                  dist1: convertSignalToDistance(
                                      deviceList[0].RSSIAverage),
                                  dist2: convertSignalToDistance(
                                      deviceList[1].RSSIAverage),
                                  dist3: convertSignalToDistance(
                                      deviceList[2].RSSIAverage),
                                )
                              : Text(
                                  "At least 3 devices in range required to triangulate user's location",
                                  textScaleFactor: 1.2,
                                )
                        ])),
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
  List<Widget> res = [];
  if (deviceList != null) {
    deviceList.forEach((device) {
      if (device.RSSIAverage != null) {
        var deviceDistance = convertSignalToDistance(device.RSSIAverage);
        var displayDistance = formatDistanceText(deviceDistance);
        var deviceID = device.id;
        var displayID = deviceID.substring(deviceID.length - 4);
        // var deviceRSSI = device.RSSIAverage;
        var displayX = device.x;
        var displayY = device.y;
        var lastRefresh = device.counter;

        res.add(Text(
          "$displayID ($displayX, $displayY) ($lastRefresh) : $displayDistance feet away",
          textScaleFactor: 1.2,
        ));
      }
    });
  }
  return res;
}

Text distanceText(double distance) {
  var dist = metersToFeet(distance).toStringAsFixed(2);
  return Text("$dist feet away", textScaleFactor: 1.5);
}

String formatDistanceText(double distance) {
  return metersToFeet(distance).toStringAsFixed(2);
}
