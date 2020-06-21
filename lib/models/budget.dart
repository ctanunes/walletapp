import 'package:testingflutterapp/models/model.dart';

class Budget extends Model {
  static String table = 'budget';

  int id;
  String name;
  double goal;

  Budget({this.id, this.name, this.goal});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'goal': goal,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Budget fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      name: map['name'],
      goal: map['goal'],
    );
  }
}
