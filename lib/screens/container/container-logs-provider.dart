import 'package:docker_client/models/container_item_service.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerLogsProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  String? container;
  bool loading = false;
  List<String> list = [];
  String tail = '50';

  ContainerLogsProvider(this.addressesProvider, this.container) {
    logs();
  }

  Future<void> logs() async {
    if ( this.container != null ) {
      loading = true;
      notifyListeners();
      if ( addressesProvider.usedAddress != null ) {
        String logs =  await ContainerItemService(addressesProvider.usedAddress!).logs(container!, tail);
        list = logs.split('\n').map((e) => e.length > 8? e.substring(8): e).toList();
      }
      loading = false;
      notifyListeners();
    }
  }
}