import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ImageListProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  List<ImageItem> totalElements = [];
  List<ImageItem> elements = [];
  bool loading = false;
  bool loadingDelete = false;
  bool loadingPrune = false;
  bool disposed = false;
  String? query;
  String? parentQuery;

  ImageListProvider(this.addressesProvider){
    loadData();
  }

  loadData() async {
    loading = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) {
      totalElements = await DockerService(addressesProvider.usedAddress!).getImageList();
      filterData();
    }
    loading = false;
    notifyListeners();
  }

  Future<String> remove(String id) async {
    loadingDelete = true;
    notifyListeners();
    var deleted = 0;
    if ( addressesProvider.usedAddress != null ) {
      try {
        deleted = await DockerService(addressesProvider.usedAddress!).removeImage(id);
      } catch (e) {
        loadingDelete = false;
        loadData();
        rethrow;
      }
    }
    loadingDelete = false;
    loadData();
    return 'Se han eliminado $deleted imagenes';
  }

  prune() async {
    loadingPrune = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).pruneImages(true);
    loadingPrune = false;
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

  void setQuery(String q) {
    query = q;
    filterData();
  }

  void setParentQuery(String q) {
    parentQuery = q;
    filterParentData();
  }

  void filterData() {
    if (query != null && query!.isNotEmpty) {
      elements = totalElements.where((element) => element.simplifiedTag().toUpperCase().contains(query!.toUpperCase())
          || (element.id != null && element.id!.toUpperCase().contains(query!.toUpperCase()))
      ).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }

  void filterParentData() {
    if (parentQuery != null && parentQuery!.isNotEmpty) {
      elements = totalElements.where((element) => element.simplifiedTag().toUpperCase().contains(parentQuery!.toUpperCase())
          || (element.parentId != null && element.parentId!.toUpperCase().contains(parentQuery!.toUpperCase()))
      ).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }
}