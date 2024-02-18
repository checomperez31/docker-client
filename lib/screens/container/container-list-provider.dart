import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:docker_client/providers/addresses_provider.dart';

class ContainerListProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  List<ContainerItem> elements = [];
  List<ContainerItem> totalElements = [];
  bool loading = false;
  bool loadingRestart = false;
  bool loadingStop = false;
  bool loadingKill = false;
  bool loadingStart = false;
  bool disposed = false;
  String? query;

  ContainerListProvider(this.addressesProvider) {
    loadData();
  }

    loadData() async {
      loading = true;
      notifyListeners();
      try {
        if ( addressesProvider.usedAddress != null ) {
          elements = await DockerService(addressesProvider.usedAddress!).getContainerList();
          totalElements = elements;
        }
      } catch (e) {
        print(e);
      }
      loading = false;
      notifyListeners();
    }

  restart(String id) async {
    loadingRestart = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).restartContainer(id);
    loadingRestart = false;
    await loadData();
  }

  stop(String id) async {
    loadingStop = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).stopContainer(id);
    loadingStop = false;
    await loadData();
  }

  remove(String id) async {
    loadingKill = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).removeContainer(id);
    loadingKill = false;
    await loadData();
  }

  start(String id) async {
    loadingStart = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).startContainer(id);
    loadingStart = false;
    await loadData();
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
      elements = totalElements.where((element) => element.simplifiedName().toUpperCase().contains(this.query!.toUpperCase())).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }
}