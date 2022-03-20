import 'package:flutter/material.dart';

import '../functions/bluetooth_scanning.dart';
import '../models/device.dart';
import '../constants/positioning.dart';

class Locate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          DeviceDistance(),
        ],
      ),
    );
  }
}

class DeviceDistance extends StatelessWidget {
  final List<Device> deviceList;
  DeviceDistance({this.deviceList});

  @override
  Widget build(BuildContext context) {
    final double minDistance = getMinDistance(deviceList);
    final double signalStrength = convertDistanceToScale(minDistance, 1.83, 6);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Paddings.ver, horizontal: Paddings.hor),
      child: deviceList != null && deviceList.isNotEmpty
          ? distanceText(minDistance)
          : Text(
              'No nearby devices',
              textScaleFactor: 1.2,
            ),
    );
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
