import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:locus/constants/positioning.dart';
import 'package:locus/functions/bluetooth_scanning.dart';

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
                if (snapshot.data.device.name.length < 1 &&
                    snapshot.data.advertisementData.connectable) {
                  snapshot.data.device.connect();
                }

                if (snapshot.data.device.name.contains('iPhone') ||
                    snapshot.data.device.name.contains('Android')) {
                  var newDevice = true;
                  var toRemove = [];
                  var signal = new Device(
                      snapshot.data.rssi,
                      snapshot.data.device.id.toString(),
                      snapshot.data.device.name,
                      0);

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

                  deviceList
                      .removeWhere((element) => toRemove.contains(element));

                  if (newDevice) {
                    deviceList.add(signal);
                  }
                }
              }

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${deviceList.length} nearby devices',
                        textScaleFactor: 1.5),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Paddings.ver, horizontal: Paddings.hor)),
                    Flexible(
                        child: FractionallySizedBox(
                      widthFactor: 0.6,
                      heightFactor: 0.7,
                      // child: Progress(deviceList: deviceList)
                    ))
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

Text distanceText(double distance) {
  return Text("Distance: ${metersToFeet(distance).toStringAsFixed(2)} ft",
      textScaleFactor: 1.2);
}

