class Device {
  int RSSILast;
  int RSSIAverage;
  List<int> RSSIValues;
  String id;
  String name;
  int counter;

  Device(int firstRSSI, this.id, this.name, this.counter){
    RSSIValues = [];
    addRSSIValue(firstRSSI);
  }

  void addRSSIValue(int value) {
    this.RSSILast = value;
    RSSIValues.add(value);
    if (RSSIValues.length > 10) {
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