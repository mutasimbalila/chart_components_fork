import 'dart:math';

import 'package:chart_components/calendar_grid_component.dart';
import 'package:flutter/material.dart';
import 'data_repository.dart';
import 'package:chart_components/bar_chart_component.dart';

class BarChartPage extends StatefulWidget {
  static const String ID = 'barchartpage';

  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  List<double> data = [];
  List<String> labels = [];
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar chart example'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'Walked km per day',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 16,
              ),
            ),
            Expanded(
              flex: 25,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'January',
                        style: Theme.of(context).textTheme.title,
                      ),
                      CalendarGrid(
                        year: 2020,
                        month: 1,
                        getColorOfDay: DataRepository.getDayColor,
                        animationDuration: Duration(milliseconds: 1500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: BarChart(
                  data: data,
                  labels: labels,
                  dislplayValue: true,
                  reverse: true,
                  getColor: DataRepository.getColor,
                  getIcon: DataRepository.getIcon,
                  barWidth: 42,
                  barSeparation: 12,
                  animationDuration: Duration(milliseconds: 1800),
                  animationCurve: Curves.easeInOutSine,
                  itemRadius: 30,
                  iconHeight: 24,
                  footerHeight: 24,
                  headerValueHeight: 16,
                  roundValuesOnText: false,
                  lineGridColor: Colors.lightBlue,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 8,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Refresh data',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: _loadData,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadData() {
    setState(() {
      if (!loaded) {
        data = DataRepository.getData();
        loaded = true;
      } else {
        data[data.length - 1] = (Random().nextDouble() * 700).round() / 100;
      }
      labels = DataRepository.getLabels();
    });
  }
}
