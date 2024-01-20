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

class Locations {
  List<Map> getAll() => _supportedLocations;

  List<String> getLocations() => _supportedLocations
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.location)
      .toList();

  List<String> getZonesByLocation(String location) => _supportedLocations
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.location == location)
      .map((item) => item.zones)
      .expand((i) => i)
      .toList();

  List _supportedLocations = [
    {
      "location": "Shalala Student Center",
      "zones": ["3rd Floor"]
    },
    {
      "location": "McArthur Engineering",
      "zones": ["2nd Floor West", "4th Floor"]
    },
  ];
}

class StateModel {
  String location;
  List<String> zones;

  StateModel({this.location, this.zones});

  StateModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    zones = json['zones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['zones'] = this.zones;
    return data;
  }
}
