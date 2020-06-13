import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

/// Sample time series data type.
class TrackerTrends {
  final DateTime time;
  final int TargetProgressValue;

  TrackerTrends(this.time, this.TargetProgressValue);
}

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => new _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    final data = [
      new TrackerTrends(new DateTime(2017, 9, 19), 5),
      new TrackerTrends(new DateTime(2017, 9, 26), 25),
      new TrackerTrends(new DateTime(2017, 10, 3), 100),
      new TrackerTrends(new DateTime(2017, 10, 10), 75),
      new TrackerTrends(new DateTime(2017, 10, 15), 1000),
    ];

    var series = [
      new Series<TrackerTrends, DateTime>(
        id: 'Likes',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TrackerTrends datas, _) => datas.time,
        measureFn: (TrackerTrends datas, _) => datas.TargetProgressValue,
        data: data,
      )
    ];

    var chart = new TimeSeriesChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      appBar: new AppBar(title: new Text("Details")),
      body: new Center(
        child: chartWidget,
      ),
    );
  }
}
