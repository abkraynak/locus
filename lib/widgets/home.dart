import 'package:flutter/material.dart';

import '../constants/buttons.dart';
import '../constants/positioning.dart';
import '../pages/dev.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
              child: ListTile(
                  title: const Text('Welcome to Locus'),
                  subtitle: const Text('Version 0.1.0'),
                  onTap: () {})),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Paddings.ver, horizontal: Paddings.hor),
            child: ElevatedButton(
              child: Text('Developer', style: ElevatedButtons.mainTextStyle),
              style: ElevatedButtons.mainButtonStyle,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DevPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
