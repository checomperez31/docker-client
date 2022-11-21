import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/models/container_item_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainerListProvider extends ChangeNotifier {
  List<ContainerItem> elements = [];
  loadData() async {
    elements = await ContainerItemService().getList();
    notifyListeners();
  }
}