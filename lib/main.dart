import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:linecharttest/classss.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/adapter_android_mp.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/legend_form.dart';
import 'package:mp_chart/mp/core/enums/limit_label_postion.dart';
import 'package:mp_chart/mp/core/limit_line.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var random = Random(1);
  int _count = 45;
  double _range = 180.0;
  LineChartController controller;

  @override
  void initState() {
    _initController();
    _initLineData(_count, _range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Center(child: _initLineChart()),
    );
  }

  void _initController() {
    var desc = Description()..enabled = false;
    LimitLine ll1 = LimitLine(150, "Upper Limit");
    ll1.setLineWidth(4);
    ll1.enableDashedLine(10, 10, 0);
    ll1.labelPosition = (LimitLabelPosition.LEFT_CENTER);
    ll1.drawBackground = true;
    ll1.textSize = (10);
    ll1.typeface =
        TypeFace(fontFamily: "OpenSans", fontWeight: FontWeight.w700);

    LimitLine ll2 = LimitLine(-30, "Lower Limit");
    ll2.drawBackground = true;
    ll2.setLineWidth(4);
    ll2.enableDashedLine(10, 10, 0);
    ll2.labelPosition = (LimitLabelPosition.RIGHT_CENTER);
    ll2.textSize = (10);
    ll2.typeface =
        TypeFace(fontFamily: "OpenSans", fontWeight: FontWeight.w700);

    LimitLine ll3 = LimitLine(10, "Upper Limit");
    ll3.setLineWidth(4);
    ll3.enableDashedLine(10, 10, 0);
    ll3.labelPosition = (LimitLabelPosition.CENTER_TOP);
    ll3.textSize = (10);
    ll3.typeface =
        TypeFace(fontFamily: "OpenSans", fontWeight: FontWeight.w700);

    LimitLine ll4 = LimitLine(20, "Lower Limit");
    ll4.setLineWidth(4);
    ll4.enableDashedLine(10, 10, 0);
    ll4.labelPosition = (LimitLabelPosition.CENTER_BOTTOM);
    ll4.textSize = (10);
    ll4.typeface =
        TypeFace(fontFamily: "OpenSans", fontWeight: FontWeight.w700);
    controller = LineChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..drawLimitLineBehindData = true
            ..enableGridDashedLine(10, 10, 0)
            ..enableAxisLineDashedLine(5, 5, 0)
            ..setAxisMaximum(400)
            ..setAxisMinimum(0);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        legendSettingFunction: (legend, controller) {
          legend.shape = (LegendForm.LINE);
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..drawLimitLineBehindData = true
            ..enableAxisLineDashedLine(5, 5, 0)
            ..enableGridDashedLine(10, 10, 0);
        },
        drawGridBackground: false,
        backgroundColor: Colors.white,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: true,
        description: desc);
  }

  void _initLineData(int count, double range) async {
    var img = Icons.star;
    List<Entry> values = List();
    Data data = new Data();

    for (var d in data.data) {
      var parsedtime = DateTime.parse(d.time);
      double day = parsedtime.day.roundToDouble();
      values.add(Entry(data: d, y: day, x: d.targetProgressValue));
    }

    LineDataSet set1;

    // create a dataset and give it a type
    set1 = LineDataSet(values, "DataSet 1");

    set1.setDrawIcons(false);

    // draw dashed line
    set1.enableDashedLine(10, 5, 0);

    // black lines and points
    set1.setColor1(Colors.black);
    set1.setCircleColor(Colors.black);
    set1.setHighLightColor(Colors.purple);

    // line thickness and point size
    set1.setLineWidth(1);
    set1.setCircleRadius(3);

    // draw points as solid circles
    set1.setDrawCircleHole(false);

    // customize legend entry
    set1.setFormLineWidth(1);
    set1.setFormLineDashEffect(DashPathEffect(10, 5, 0));
    set1.setFormSize(15);

    // text size of values
    set1.setValueTextSize(9);

    // draw selection line as dashed
    set1.enableDashedHighlightLine(10, 5, 0);

    // set the filled area
    set1.setDrawFilled(true);
//    set1.setFillFormatter(A(lineChart.painter));

    // set color of filled area
    set1.setGradientColor(Colors.blue, Colors.red);

    List<ILineDataSet> dataSets = List();
    dataSets.add(set1); // add the data sets

    // create a data object with the data sets
    controller.data = LineData.fromList(dataSets);

    setState(() {});
  }

  Widget _initLineChart() {
    var lineChart = LineChart(controller);
    controller.animator
      ..reset()
      ..animateX1(1500);
    return lineChart;
  }
}
