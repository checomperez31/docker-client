import 'package:docker_client/models/container_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ContainersProvider extends ChangeNotifier {
  List<ContainerItem> containers = [];
  ContainerItem? selected;

  void add(ContainerItem data) {
    int existing = containers.indexWhere((element) => element.id == data.id);
    if ( existing < 0 ) {
      containers.add( data );
      select( data );
    } else if ( selected == null ) {
      select( containers.elementAt( existing ) );
    }
  }

  void select(ContainerItem selectedContainer) {
    selected = selectedContainer;
    notifyListeners();
  }

  void unselect() {
    selected = null;
    notifyListeners();
  }

  void close() {
    if ( selected != null ) {
      containers.remove( selected );
      selected = null;
      notifyListeners();
    }
  }

  void remove(ContainerItem data) {
    if ( containers.where((element) => element.id == data.id).isNotEmpty ) {
      containers.remove( data );
    }
    notifyListeners();
  }
}