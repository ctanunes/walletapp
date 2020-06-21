import 'package:testingflutterapp/models/model.dart';

class BudgetItemsList extends Model {
  static String table = 'budget_items_list';

  int budget_items_id;
  int budget_id;

  BudgetItemsList({this.budget_items_id, this.budget_id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'budget_items_id': budget_items_id,
      'budget_id': budget_id,
    };

    return map;
  }

  static BudgetItemsList fromMap(Map<String, dynamic> map) {
    return BudgetItemsList(
      budget_items_id: map['budget_items_id'],
      budget_id: map['budget_id'],
    );
  }
}
