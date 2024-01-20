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

import 'dart:math';

double convertSignalToDistance(int powerLevel){
  // Convert signal strength to distance (meters)
  
  double measuredPower = -69.0; // BLE
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