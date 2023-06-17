import 'package:docker_client/preferences/preferences.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddressesProvider extends ChangeNotifier {
  String? usedAddress;
  List<String> addresses = [];

  AddressesProvider() {
    addresses = Preferences.list;
    usedAddress = Preferences.selected;
  }

  add(String? data) {
    if ( data != null && data.isNotEmpty) {
      data = data.trim();
      if ( !data.contains(':') ) {
        data = '$data:2375';
      }
      addresses.add( data );
      DockerService( data ).systemInfo();
      Preferences.list = addresses;
    }
    notifyListeners();
  }

  use(String data) {
    usedAddress = data;
    Preferences.selected = usedAddress;
    notifyListeners();
  }

  delete(String data) {
    addresses.remove(data);
    Preferences.selected = usedAddress;
    notifyListeners();
  }
}