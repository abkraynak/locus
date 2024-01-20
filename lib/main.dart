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

import 'constants/colors.dart';
import 'constants/route_names.dart';
import 'pages/home.dart';
import 'pages/locate.dart';
import 'widgets/app_route_observer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locus',
      theme: ThemeData(
          primaryColor: ThemeColors.primary,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: Map<TargetPlatform,
                    _InanimatePageTransitionsBuilder>.fromIterable(
                TargetPlatform.values.toList(),
                key: (dynamic k) => k,
                value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
          )),
      initialRoute: RouteNames.home,
      navigatorObservers: [AppRouteObserver()],
      routes: {
        RouteNames.home: (context) => HomePage(),
        RouteNames.locate: (context) => LocatePage(),
      },
    );
  }
}

class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
