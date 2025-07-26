import 'package:docker_client/models/address.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

class DirectionSelectorProvider extends ChangeNotifier {
  bool disposed = false;
  String? query;
  AddressesProvider provider;
  bool loading = false;
  List<Address> elements = [];
  List<Address> totalElements = [];
  int? preselectedIndex;
  Address? preselectedElement;

  DirectionSelectorProvider(this.provider) {
    loadData();
  }

  loadData() async {
    loading = true;
    notifyListeners();
    try {
      elements = provider.addresses;
      totalElements = elements;
    } catch (e) {
      print(e);
    }
    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if ( !disposed ) {
      super.notifyListeners();
    }
  }

  setQuery(String query) {
    this.query = query;
    if ( this.query != null && this.query!.isNotEmpty ) {
      elements = totalElements.where((address) => (address.name != null && address.name!.toUpperCase().contains(this.query!.toUpperCase()))
        || (address.ip != null && address.ip!.toUpperCase().contains(this.query!.toUpperCase()))).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }

  pressedKeyOnSearch(String label, int value) {
    switch(value) {
      case 4294968068: //Up
        updateIndexUp();
        break;
      case 4294968065: //Down
        updateIndexDown();
        break;
      /*case 4294967309: //Submit
        submitData();
        break;*/
    }
    notifyListeners();
  }

  updateIndexUp() {
    if (preselectedIndex == null) {
      preselectedIndex = -1;
      return;
    }
    if ( preselectedIndex! >= 1 ) {
      preselectedIndex = preselectedIndex! - 1;
      preselectedElement = elements[ preselectedIndex! ];
    }
  }

  updateIndexDown() {
    if (preselectedIndex == null) {
      preselectedIndex = 0;
      preselectedElement = elements[ preselectedIndex! ];
      return;
    }
    if ( preselectedIndex! < (elements.length - 1) ) {
      preselectedIndex = preselectedIndex! + 1;
      preselectedElement = elements[ preselectedIndex! ];
    }
  }

  Address? submitData() {
    if ( preselectedIndex == null ) {
      if ( elements.isNotEmpty ) {
        return elements[0];
      }
    } else {
      if ( elements.isNotEmpty ) {
        return elements[preselectedIndex!];
      }
    }
    return null;
  }
}