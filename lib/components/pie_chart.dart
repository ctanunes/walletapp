/// Simple pie chart example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:testingflutterapp/models/budget.dart';
import 'package:testingflutterapp/services/db.dart';

// ignore: must_be_immutable
class SimplePieChart extends StatefulWidget {
  SimplePieChart(this.goal);

  int goal;
  @override
  _SimplePieChartState createState() {
    return _SimplePieChartState(this.goal);
  }
}

class _SimplePieChartState extends State<SimplePieChart> {

  List<charts.Series> seriesList;
  List<charts.Series> seriesListNew;
  bool animate;
  int goal;
  _SimplePieChartState(this.goal);

  /// Creates a [PieChart] with sample data and no transition.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<charts.Series<LinearSales, int>>>(
        future: _createSampleData(goal),
        builder: (context, AsyncSnapshot<List<charts.Series<LinearSales, int>>> seriesList) {
          if (seriesList.hasData) {
            return charts.PieChart(
                seriesList.data,
                animate: false);
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }

  Future<Budget> giveData(int goal) async {
    List<Budget> _tasks = [];
    List<Map<String, dynamic>> _results =
        await DB.rawQuery('SELECT * FROM budget WHERE budget.id="$goal";');
    _tasks = _results.map((item) => Budget.fromMap(item)).toList();
    Budget budgetToDisplay = _tasks[0];
    return budgetToDisplay;
  }

  Future<double> giveDataSum(int goalID) async {
    List<Budget> _tasks = [];
    List<Map<String, dynamic>> _results = await DB.rawQuery(
        'SELECT sum(value) AS value FROM (SELECT budget_items.* FROM budget_items INNER JOIN budget_items_list ON budget_items_list.budget_items_id=budget_items.id INNER JOIN budget ON budget.id=budget_items_list.budget_id WHERE budget.id="$goalID");');
    _tasks = _results.map((item) => Budget.fromMap(item)).toList();
    String x = _results[0].values.toString().replaceAll(new RegExp(r'[\(,\)]'), "");
    double y = double.parse(x);
    return y;
  }

  /// Create one series with sample hard coded data.
  Future<List<charts.Series<LinearSales, int>>> _createSampleData(int goal) async {

    // Calculate percentages
    //get goal value
    Budget budgetDisplay = await giveData(goal);

    double goalValue = budgetDisplay.goal;

    double keepValue = await giveDataSum(goal);

    double graphLine = goalValue - keepValue;
    //print(graphLine.round());
    final data = [
      new LinearSales(0, keepValue.round()), // value saved = x
      new LinearSales(1, graphLine.round()), // value to save = goal - x
    ];


    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
    //return seriesList;
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
