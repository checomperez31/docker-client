import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _instance;

  static List<String>? _list;
  static String? _selected;

  static Future init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static List<String> get list => _list ?? _instance.getStringList('list') ?? [];

  static String? get selected => _selected ?? _instance.getString('selected');

  static set list(List<String>? value) {
    if ( value != null ) {
      _list = value;
      _instance.setStringList('list', value);
    } else {
      _list = null;
      _instance.remove('list');
    }
  }

  static set selected(String? value) {
    if ( value != null ) {
      _selected = value;
      _instance.setString('selected', value);
    } else {
      _selected = null;
      _instance.remove('selected');
    }
  }


}