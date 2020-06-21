import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testingflutterapp/components/input_reset_all.dart';
import 'package:testingflutterapp/components/pie_chart.dart';
import 'package:testingflutterapp/components/custom_list_item.dart';
import 'package:testingflutterapp/models/budget_item.dart';
import 'package:testingflutterapp/models/budget.dart';
import 'package:testingflutterapp/screens/input_page.dart';
import 'package:testingflutterapp/screens/input_page_goal.dart';
import 'package:testingflutterapp/screens/input_page_income.dart';
import 'package:testingflutterapp/services/db.dart';
import 'package:sqflite/sqflite.dart';

import 'components/input_set_wallet.dart';

SharedPreferences prefs;
double _counter = 9876;
double _startingvalue = 987;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MaterialApp(title: 'Wallet App',theme: ThemeData.light(),home: MyApp(), ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool scrollVisible = true;

  @override
  void initState() {
    refresh();
    super.initState();
    _loadCounter();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  //Loading counter value on start
  _loadCounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getDouble('counter') ?? 0.0);
    });
  }

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }


  //Remain in your wallet widget
  Widget buildCard() {
    double counter = prefs.getDouble('counter') ?? 0.0;
    double start = prefs.getDouble('start_value') ?? 0.0;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(counter.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                )),
            title: Text('Remaining in your wallet',
                style: TextStyle(
                  fontSize: 20,
                )),
            subtitle: Text('The starting value was ' + start.toString(),
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          Divider(),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('RESET ALL VALUES'),
                onPressed: () {
                  InputResetAll().build(context);
                  },
              ),
              FlatButton(
                child: const Text('SET WALLET VALUE'),
                onPressed: () async {
                  InputSetWallet().build(context);
                  /*_asyncInputDialog(context);*/
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return ListView(children: _items);
  }

  Widget buildGoals() {
    return GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          //padding: const EdgeInsets.all(10),
          //crossAxisSpacing: 10,
          //mainAxisSpacing: 5,
          childAspectRatio: 2/1,
          crossAxisCount: 2,
          children: _goals);
  }

  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.remove, color: Colors.grey[850]),
            title: "Expense",
            titleColor: Colors.grey[850],
            subtitle: "Make a budget expense",
            subTitleColor: Colors.grey[850],
            backgroundColor: Colors.grey[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          ),
          MenuItem(
              child: Icon(Icons.add, color: Colors.grey[850]),
              title: "Income",
              titleColor: Colors.white,
              subtitle: "Add a budget income",
              subTitleColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRouteIncome()),
                );
              }
              ),
          MenuItem(
              child: Icon(Icons.add, color: Colors.grey[850]),
              title: "Goal",
              titleColor: Colors.white,
              subtitle: "Add goal you want to reach",
              subTitleColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRouteGoal()),
                );
              })
        ]);
  }
  //Budjet Items

  String _task;

  List<BudgetItem> _tasks = [];
  List<Budget> _budget = [];

  TextStyle _style = TextStyle(color: Colors.white, fontSize: 24);

  List<Widget> get _items =>
      _tasks.reversed.map((item) => format(item)).toList();

  List<Widget> get _goals =>
      _budget.map((goal) => formatBudgets(goal)).toList();

  Widget formatBudgets(Budget goal) {
    return CustomListItem(
      user: 'You goal is',
      viewCount: goal.goal,
      thumbnail: SimplePieChart(goal.id),
      title: goal.name,
      id: goal.id,
    );
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

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(BudgetItem.table);
    _tasks = _results.map((item) => BudgetItem.fromMap(item)).toList();

    List<Map<String, dynamic>> _resultsBudget = await DB.query(Budget.table);
    _budget = _resultsBudget.map((goal) => Budget.fromMap(goal)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet App'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: SafeArea(
            child: AboutListTile(
              icon: Icon(Icons.info),
              applicationIcon: FlutterLogo(),
              applicationName: 'About this app',
              applicationVersion: 'Catarina Nunes',
              applicationLegalese: '© 2020 ',
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          buildCard(),
          buildGoals(),
          Expanded(
            child: buildBody(),
          ),
        ],
      ),
      floatingActionButton: buildBoomMenu(),
    );
  }
}
