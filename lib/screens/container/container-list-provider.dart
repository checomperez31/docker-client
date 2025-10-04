import 'package:docker_client/models/container-create.dart';
import 'package:docker_client/models/container.dart' show DockerContainer;
import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
  String? portQuery;

  ContainerListProvider(this.addressesProvider) {
    loadData();
    addressesProvider.addListener(loadData);
  }

  loadData() async {
    loading = true;
    notifyListeners();
    try {
      if (addressesProvider.usedAddress != null) {
        totalElements = await DockerService(addressesProvider.usedAddress!).getContainerList();
        filterData();
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
    if (addressesProvider.usedAddress != null) await DockerService(addressesProvider.usedAddress!).restartContainer(id);
    loadingRestart = false;
    await loadData();
  }

  stop(String id) async {
    loadingStop = true;
    notifyListeners();
    if (addressesProvider.usedAddress != null) await DockerService(addressesProvider.usedAddress!).stopContainer(id);
    loadingStop = false;
    await loadData();
  }

  remove(String id) async {
    loadingKill = true;
    notifyListeners();
    if (addressesProvider.usedAddress != null) await DockerService(addressesProvider.usedAddress!).removeContainer(id);
    loadingKill = false;
    await loadData();
  }

  start(String id) async {
    loadingStart = true;
    notifyListeners();
    if (addressesProvider.usedAddress != null) await DockerService(addressesProvider.usedAddress!).startContainer(id);
    loadingStart = false;
    await loadData();
  }

  Future<DockerContainer?> details(String id) async {
    loadingStart = true;
    notifyListeners();
    if (addressesProvider.usedAddress != null) {
      var entityDet = await DockerService(addressesProvider.usedAddress!).getContainerInfo(id);
      loadingStart = false;
      notifyListeners();
      return entityDet;
    }
    loadingStart = false;
    notifyListeners();
    return null;
  }

  Future<Map<String, dynamic>?> create(DockerCreate entity) async {
    loadingStart = true;
    notifyListeners();
    if (addressesProvider.usedAddress != null) {
      var data = await DockerService(addressesProvider.usedAddress!).createContainer( entity );
      loadingStart = false;
      notifyListeners();
      return data;
    }
    loadingStart = false;
    notifyListeners();
    return null;
  }

  @override
  void dispose() {
    disposed = true;
    addressesProvider.removeListener(loadData);
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  setQuery(String q) {
    query = q;
    filterData();
  }

  setPortQuery(String q) {
    portQuery = q;
    filterPortData();
  }

  void filterData() {
    if (query != null && query!.isNotEmpty) {
      elements = totalElements.where((element) => element.simplifiedName().toUpperCase().contains(query!.toUpperCase())
          || element.simplifiedPort().contains(query!)
          || (element.image != null && element.image!.contains(query!))
          || (element.imageId != null && element.imageId!.contains(query!))
      ).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }

  void filterPortData() {
    if (portQuery != null && portQuery!.isNotEmpty) {
      elements = totalElements.where((element) => element.simplifiedName().toUpperCase().contains(portQuery!.toUpperCase())
          || element.simplifiedPort().contains(portQuery!)
      ).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }
}
