/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.
///
library;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartData {
  ChartData(this.x, this.y);
 
  final String x;
  final double y;
}

class DonutAutoLabelChart extends StatelessWidget {
  final String name;
  final List<ChartData> data;
  final TooltipBehavior? tooltip;

  const DonutAutoLabelChart({super.key, required this.data, required this.name, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
            tooltipBehavior: tooltip,
            series: <CircularSeries<ChartData, String>>[
              DoughnutSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: name)
            ]);
  }
}
