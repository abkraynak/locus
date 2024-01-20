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

class ScanInactive extends StatefulWidget {
  @override
  _ScanInactiveState createState() => _ScanInactiveState();
}

class _ScanInactiveState extends State<ScanInactive> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Scanning is off", textScaleFactor: 1.5),
        Text("Tap the icon below to start scanning")
      ],
    ));
  }
}
