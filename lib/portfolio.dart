import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:pie_chart/pie_chart.dart';
import 'main.dart';


bool togglee = true;

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  bool toggle = false;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Bitcoin", () => 5);
    dataMap.putIfAbsent("ETH", () => 3);
    dataMap.putIfAbsent("LTC", () => 2);
    dataMap.putIfAbsent("MMO", () => 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Portfolio"),
      ),
      body: Container(
        child: 
        Center(
          child: togglee
              ? PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width,
                  showChartValuesInPercentage: true,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 1,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                )
              : Text("Press FAB to show chart"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: togglePieChart,
        child: Icon(Icons.insert_chart),
      ),
    );
  }

  void togglePieChart() {
    setState(() {
      togglee = !togglee;
    });
  }
}
