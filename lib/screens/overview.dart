import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/overviewpage.dart';

class Overview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: OverviewWidget(),
    );
  }
}
