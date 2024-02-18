import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

class DirectionSelectorProvider extends ChangeNotifier {
  bool disposed = false;
  String? query;
  AddressesProvider provider;
  bool loading = false;
  List<String> elements = [];
  List<String> totalElements = [];

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
      elements = totalElements.where((element) => element.toUpperCase().contains(this.query!.toUpperCase())).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }
}