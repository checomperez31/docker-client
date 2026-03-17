import 'package:docker_client/models/address.dart';
import 'package:docker_client/preferences/preferences.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddressesProvider extends ChangeNotifier {
  String? usedAddress;
  String? usedClient;
  List<Address> addresses = [];

  AddressesProvider() {
    addresses = Preferences.list.map((address) {
      if (address.contains('{')) {
        return Address.fromRawJson(address);
      } else {
        return Address(ip: address);
      }
    }).toList();
    usedAddress = Preferences.selected;
    usedClient = Preferences.selectedClient;
  }

  test() {
    print(addresses);
  }

  add(Address? data) {
    if ( data != null ) {
      if ( data.ip != null && data.ip!.isNotEmpty) {
        data.ip = data.ip!.trim();
        if ( !data.ip!.contains(':') ) {
          data.ip = '${data.ip}:2375';
        }
        addresses.add( data );
        // DockerService( data.ip! ).systemInfo();
        Preferences.list = addresses.map((add) => add.toRawJson()).toList();
      }
    }
    notifyListeners();
  }

  edit(int position, Address? data) {
    if ( data != null ) {
      if ( data.ip != null && data.ip!.isNotEmpty) {
        data.ip = data.ip!.trim();
        if ( !data.ip!.contains(':') ) {
          data.ip = '${data.ip}:2375';
        }
        addresses[position] = data;
        // DockerService( data.ip! ).systemInfo();
        Preferences.list = addresses.map((add) => add.toRawJson()).toList();
      }
    }
    notifyListeners();
  }

  use(Address data) {
    usedAddress = data.ip;
    usedClient = data.client ?? 'v1.24';
    Preferences.selected = usedAddress;
    Preferences.selectedClient = usedClient;
    notifyListeners();
  }

  delete(int data) {
    addresses.removeAt(data);
    Preferences.selected = usedAddress;
    Preferences.selectedClient = usedClient;
    Preferences.list = addresses.map((add) => add.toRawJson()).toList();
    notifyListeners();
  }
}