import 'package:docker_client/models/container_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainersProvider extends ChangeNotifier {
  List<ContainerItem> containers = [];
  ContainerItem? selected;

  add(ContainerItem data) {
    if ( containers.where((element) => element.id == data.id).isEmpty ) {
      containers.add( data );
    }
    notifyListeners();
  }

  select(ContainerItem selectedContainer) {
    selected = selectedContainer;
    notifyListeners();
  }

  unselect() {
    selected = null;
    notifyListeners();
  }

  remove(ContainerItem data) {
    if ( containers.where((element) => element.id == data.id).isNotEmpty ) {
      containers.remove( data );
    }
    notifyListeners();
  }
}