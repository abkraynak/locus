import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/locate.dart';

class LocatePage extends StatefulWidget {
  @override
  _LocatePageState createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(PageTitles.locate),
        ),
        body: Locate());
  }
}
