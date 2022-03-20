import 'package:flutter/material.dart';

import '../constants/page_titles.dart';
import '../widgets/dev.dart';

class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(PageTitles.dev),
        ),
        body: Dev());
  }
}
