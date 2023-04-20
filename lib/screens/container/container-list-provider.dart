import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/models/container_item_service.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  List<ContainerItem> elements = [];
  bool loading = false;
  bool loadingRestart = false;
  bool loadingStop = false;
  bool loadingKill = false;
  bool loadingStart = false;

  ContainerListProvider(this.addressesProvider) {
    loadData();
  }

  loadData() async {
    loading = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) elements = await ContainerItemService(addressesProvider.usedAddress!).getList();
    loading = false;
    notifyListeners();
  }

  restart(String id) async {
    loadingRestart = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ContainerItemService(addressesProvider.usedAddress!).restart(id);
    loadingRestart = false;
    await loadData();
  }

  stop(String id) async {
    loadingStop = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ContainerItemService(addressesProvider.usedAddress!).stop(id);
    loadingStop = false;
    await loadData();
  }

  remove(String id) async {
    loadingKill = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ContainerItemService(addressesProvider.usedAddress!).remove(id);
    loadingKill = false;
    await loadData();
  }

  start(String id) async {
    loadingStart = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ContainerItemService(addressesProvider.usedAddress!).start(id);
    loadingStart = false;
    await loadData();
  }
}