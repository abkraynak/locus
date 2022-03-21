import 'package:flutter/material.dart';

import '../constants/buttons.dart';
import '../constants/page_titles.dart';
import '../constants/positioning.dart';
import '../pages/locate.dart';

class HomeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Paddings.logoVer, horizontal: Paddings.logoHor),
              child: Container(
                child: Image.asset('assets/logo/locus_transparent.png'),
              )),
          Card(
              child: ListTile(
                  title: const Text('Welcome to Locus'),
                  subtitle: const Text('Tap "Locate" to begin. Let\'s go!'),
                  onTap: () {})),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Paddings.ver, horizontal: Paddings.hor),
            child: ElevatedButton(
              child: Text(PageTitles.locate, style: ElevatedButtons.mainTextStyle),
              style: ElevatedButtons.mainButtonStyle,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocatePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
