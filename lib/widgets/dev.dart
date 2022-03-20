import 'package:flutter/material.dart';

import '../constants/buttons.dart';
import '../constants/positioning.dart';
// import '../pages/home.dart';

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
