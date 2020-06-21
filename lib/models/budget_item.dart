import 'package:testingflutterapp/models/model.dart';

class BudgetItem extends Model {
  static String table = 'budget_items';

  int id;
  String name;
  double value;
  int income;

  BudgetItem({this.id, this.name, this.value, this.income});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'value': value.toString(),
      'income': income,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static BudgetItem fromMap(Map<String, dynamic> map) {
    return BudgetItem(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      income: map['income'],
    );
  }
}
