import 'package:flutter/material.dart';
import 'package:testingflutterapp/components/goal_body.dart';
import 'package:testingflutterapp/components/input_form.dart';
import 'package:testingflutterapp/components/pie_chart.dart';
import 'package:testingflutterapp/models/budget.dart';
import 'package:testingflutterapp/models/budget_item.dart';
import 'package:testingflutterapp/services/db.dart';

import 'input_page_goal_expense.dart';

List<BudgetItem> _tasks;

class SecondRouteGoalPage extends StatelessWidget {
  void initState() {
    refresh();
  }

  final String title;

  int id;
  double valueToReach;
  double budgetToDisplay;

  SecondRouteGoalPage({Key key, @required this.title, this.id})
      : super(key: key);

  Future<List<BudgetItem>> refresh() async {
    id = this.id;
    print(id);
    //Values of goal
    List<Budget> _tasksOther = [];
    List<Map<String, dynamic>> _resultsTwo =
    await DB.rawQuery('SELECT * FROM budget WHERE budget.id="$id";');
    _tasksOther = _resultsTwo.map((item) => Budget.fromMap(item)).toList();
    budgetToDisplay = _tasksOther[0].goal;

    List<Map<String, dynamic>> _resultsOne = await DB.rawQuery(
        'SELECT sum(value) AS value FROM (SELECT budget_items.* FROM budget_items INNER JOIN budget_items_list ON budget_items_list.budget_items_id=budget_items.id INNER JOIN budget ON budget.id=budget_items_list.budget_id WHERE budget.id="$id");');
    String x = _resultsOne[0].values.toString().replaceAll(new RegExp(r'[\(,\)]'), "");

    if(x != "null"){
      double y = double.parse(x);
      valueToReach=budgetToDisplay-y;
    }else{
      valueToReach=budgetToDisplay;
    }

    List<Map<String, dynamic>> _results = await DB.rawQuery(
        'SELECT budget_items.* FROM budget_items INNER JOIN budget_items_list ON budget_items_list.budget_items_id=budget_items.id INNER JOIN budget ON budget.id=budget_items_list.budget_id WHERE budget.id="$id";');
    _tasks = _results.map((item) => BudgetItem.fromMap(item)).toList();

    //print(_tasks);

    return _tasks;
  }

  List<Widget> get _items =>
      _tasks.reversed.map((item) => format(item)).toList();

  Widget buildNewBody() {
    //print(_items);
    return ListView(children: _items);
  }

  Widget format(BudgetItem item) {
    if (item.income == 0) {
      return Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          leading: Text('-' + item.value.toString(),
              style: TextStyle(
                fontSize: 20,
              )),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  )),
            ],
          ),
        )
      ]));
    } else {
      return Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          leading: Text('+' + item.value.toString(),
              style: TextStyle(
                fontSize: 20,
              )),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  )),
            ],
          ),
        )
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BudgetItem>>(
        future: refresh(),
        builder: (context, AsyncSnapshot<List<BudgetItem>> _tasks) {
          if (_tasks.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Column(
                children: <Widget>[
                  customCard(context),
                  Expanded(
                    child: buildNewBody(),
                  ),
                  //Add list of budget Items for this goal
                ],
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        });
  }

  Widget customCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Container(
        child: new Stack(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                  height: 250.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(valueToReach.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 40,
                            )),
                        Text(
                          "To reach this goal",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        ButtonBar(
                          mainAxisSize: MainAxisSize
                              .min, // this will take space as minimum as posible(to center)
                          children: <Widget>[
                            new RaisedButton(
                              child: new Text('ADD EXPENSE'),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SecondRouteGoalExpense(id)),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.4),
              child: Align(
                child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: SimplePieChart(id)),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
