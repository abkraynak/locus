import 'dart:math';

double convertSignalToDistance(int powerLevel){
  // Convert signal strength to distance (meters)
  
  double measuredPower = -69.0;
  double N = 2.0;

  return pow(10, ((measuredPower - powerLevel) / (10 * N)));
}

double convertDistanceToScale(double distance, double min, double max){
  if(distance <= min){
    return 1;
  } else if(distance > max){
    return 0;
  } else{
    return scaleValue(distance, min, max);
  }
}

double scaleValue(double value, double lower, double upper) {
  double res = (value - upper) / (lower - upper);

  if(res == -0.0){
    res = 0;
  }
  return res;
}

double metersToFeet(double distanceMeters){
  return distanceMeters * 3.2808;
}