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
