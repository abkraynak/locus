import 'package:flutter/material.dart';

import '../constants/buttons.dart';
import '../constants/positioning.dart';
import '../pages/home.dart';

import 'package:flutter_blue/flutter_blue.dart';


/*
BluetoothDevice device;
BluetoothState state;
BluetoothDeviceState deviceState;

///Initialisation and listening to device state@override
@override
void initState() {
  super.initState();

  //checks bluetooth current state
  FlutterBlue.instance.state.listen((state) {
    if (state == BluetoothState.off) {
      //Alert user to turn on bluetooth.
    } else if (state == BluetoothState.on) {
      //if bluetooth is enabled then go ahead.
      // Make sure user's device gps is on.
      scanForDevices();
    }
  });
}

void scanForDevices() async {
  scanSubscription = bluetoothInstance.scan().listen((scanResult) async {
    if (scanResult.device.name == "your_device_name") {
      print("found device");
      device = scanResult.device; //Assigning bluetooth device
      stopScanning(); //After that we stop the scanning for device
}});}

void stopScanning() {
  bluetoothInstance.stopScan();
  scanSubscription.cancel();
}

*/


class Dev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
              child: ListTile(
                  title: const Text(''),
                  subtitle: const Text(''),
                  onTap: () {})),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Paddings.ver, horizontal: Paddings.hor),
            child: ElevatedButton(
              child: Text('Connect', style: ElevatedButtons.mainTextStyle),
              style: ElevatedButtons.mainButtonStyle,
              onPressed: () {
                /* Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage())); */
              },
            ),
          ),
        ],
      ),
    );
  }
}
