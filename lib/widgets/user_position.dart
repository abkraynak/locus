import 'package:flutter/material.dart';

class UserPosition extends StatefulWidget {
  @override
  _UserPositionState createState() => _UserPositionState();
}

class _UserPositionState extends State<UserPosition> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User's Position: (18.62, 29.96)", textScaleFactor: 1.2,)
          ],
        ));
  }
}
