import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/route_names.dart';
import 'pages/locate.dart';
import 'pages/home.dart';
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
