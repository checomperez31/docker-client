import 'package:fluent_ui/fluent_ui.dart';

class AddressesProvider extends ChangeNotifier {
  String? usedAddress;
  List<String> addresses = [];

  add(String? data) {
    if ( data != null && data.isNotEmpty) addresses.add( data.trim() );
    notifyListeners();
  }

  use(String data) {
    usedAddress = data;
    notifyListeners();
  }
}