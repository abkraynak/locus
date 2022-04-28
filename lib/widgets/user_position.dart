import 'package:flutter/material.dart';
import 'dart:math';

class UserPosition extends StatefulWidget {
  double dist1;
  double dist2;
  double dist3;
  UserPosition({this.dist1, this.dist2, this.dist3});

  @override
  _UserPositionState createState() => _UserPositionState();
}

class _UserPositionState extends State<UserPosition> {
  double r1;

  @override
  Widget build(BuildContext context) {
    double x1 = 0;
    double y1 = 0;
    double x2 = 5;
    double y2 = 15;
    double x3 = 20;
    double y3 = 9;

    double r1 = widget.dist1;
    double r2 = widget.dist2;
    double r3 = widget.dist3;

    double x = getUserXPosition(x1, y1, r1, x2, y2, r2, x3, y3, r3);
    double y = getUserYPosition(x1, y1, r1, x2, y2, r2, x3, y3, r3);

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User's Position ($x, $y)", textScaleFactor: 1.2,),
          ],
        ));
  }
}

double getA(double x1, double x2){
  return 2*x2 - 2*x1;
}

double getB(double y1, double y2){
  return 2*y2 - 2*y1;
}

double getC(double r1, double r2, double x1, double x2, double y1, double y2){
  return pow(r1, 2) - pow(r2, 2) - pow(x1, 2) + pow(x2, 2) - pow(y1, 2) + pow(y2, 2);
}

double getD(double x2, double x3){
  return 2*x3 - 2*x2;
}

double getE(double y2, double y3){
  return 2*y3 - 2*y2;
}

double getF(double r2, double r3, double x2, double x3, double y2, double y3){
  return pow(r2, 2) - pow(r3, 2) - pow(x2, 2) + pow(x3, 2) - pow(y2, 2) + pow(y3, 2);
}

double getUserXPosition(double x1, double y1, double r1, double x2, double y2, double r2, double x3, double y3, double r3){
  double A = getA(x1, x2);
  double B = getB(y1, y2);
  double C = getC(r1, r2, x1, x2, y1, y2);
  double D = getD(x2, x3);
  double E = getE(y2, y3);
  double F = getF(r2, r3, x2, x3, y2, y3);

  return (C*E - F*B) / (E*A - B*D);
}

double getUserYPosition(double x1, double y1, double r1, double x2, double y2, double r2, double x3, double y3, double r3){
  double A = getA(x1, x2);
  double B = getB(y1, y2);
  double C = getC(r1, r2, x1, x2, y1, y2);
  double D = getD(x2, x3);
  double E = getE(y2, y3);
  double F = getF(r2, r3, x2, x3, y2, y3);

  return (C*D - A*F) / (B*D - A*E);
}