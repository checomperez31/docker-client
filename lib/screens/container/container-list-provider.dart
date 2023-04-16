import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/models/container_item_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListProvider extends ChangeNotifier {
  List<ContainerItem> elements = [];
  bool loading = false;
  bool loadingRestart = false;
  bool loadingStop = false;
  bool loadingKill = false;

  loadData() async {
    loading = true;
    notifyListeners();
    elements = await ContainerItemService().getList();
    notifyListeners();
  }

  restart(String id) async {
    loadingRestart = true;
    notifyListeners();
    await ContainerItemService().restart(id);
    loadingRestart = false;
    await loadData();
  }

  stop(String id) async {
    loadingStop = true;
    notifyListeners();
    await ContainerItemService().stop(id);
    loadingStop = false;
    await loadData();
  }

  remove(String id) async {
    loadingKill = true;
    notifyListeners();
    await ContainerItemService().remove(id);
    loadingKill = false;
    await loadData();
  }
}