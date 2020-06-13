import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

/// Sample time series data type.
class TrackerTrends {
  final DateTime time;
  final int targetProgressValue;

  TrackerTrends(this.time, this.targetProgressValue);
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
      new TrackerTrends(DateTime.parse("2020-05-31T01:21:30.781702"), 5),
      new TrackerTrends(DateTime.parse('2020-05-31T01:21:30.781702'), 25),
      new TrackerTrends(DateTime.parse("2020-05-29T14:59:29.412717"), 100),
      new TrackerTrends(DateTime.parse("2020-05-29T17:21:14.690870"), 75),
      new TrackerTrends(DateTime.parse("2020-05-30T01:21:28.835976"), 400),
      new TrackerTrends(DateTime.parse("2020-06-05T01:21:28.835976"), 267),
    ];

    var series = [
      new Series<TrackerTrends, DateTime>(
        id: 'Likes',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TrackerTrends datas, _) => datas.time,
        measureFn: (TrackerTrends datas, _) => datas.targetProgressValue,
        data: data,
      )
    ];

    return Scaffold(
      appBar: new AppBar(title: new Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TimeSeriesChart(
          series,
          animate: true,
          behaviors: [
            ChartTitle("Like",
                behaviorPosition: BehaviorPosition.top,
                titleOutsideJustification: OutsideJustification.middleDrawArea),
            ChartTitle("Date",
                behaviorPosition: BehaviorPosition.bottom,
                titleOutsideJustification: OutsideJustification.middleDrawArea),
            ChartTitle("Progress",
                behaviorPosition: BehaviorPosition.start,
                titleOutsideJustification: OutsideJustification.middleDrawArea),
            ChartTitle("Area",
                behaviorPosition: BehaviorPosition.end,
                titleOutsideJustification: OutsideJustification.middleDrawArea),
          ],
          defaultRenderer:
              LineRendererConfig(includeArea: true, includePoints: true),
        ),
      ),
    );
  }
}
