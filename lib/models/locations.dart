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
