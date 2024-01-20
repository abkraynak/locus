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

class Device {
  int RSSILast;
  int RSSIAverage;
  List<int> RSSIValues;
  String id;
  String name;
  int counter;
  int x;
  int y;

  Device(int firstRSSI, this.id, this.name, this.counter) {
    RSSIValues = [];
    addRSSIValue(firstRSSI);
  }

  void addRSSIValue(int value) {
    this.RSSILast = value;
    RSSIValues.add(value);
    if (RSSIValues.length > 20) {
      RSSIValues.removeAt(0);
    }
    calculateRSSIAverage();
  }

  void calculateRSSIAverage() {
    var sum = 0;
    RSSIValues.forEach((element) {
      sum += element;
    });

    this.RSSIAverage = sum ~/ RSSIValues.length;
  }
}
