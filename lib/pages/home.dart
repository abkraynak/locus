import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/home_display.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(PageTitles.home),
        ),
        body: HomeDisplay());
  }
}
