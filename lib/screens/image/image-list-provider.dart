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

  remove(String id) async {
    loadingDelete = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await DockerService(addressesProvider.usedAddress!).removeImage(id);
    loadingDelete = false;
    await loadData();
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

  setQuery(String query) {
    this.query = query;
    filterData();
  }

  filterData() {
    if (query != null && query!.isNotEmpty) {
      elements = totalElements.where((element) => element.simplifiedTag().toUpperCase().contains(query!.toUpperCase())).toList();
    } else {
      elements = totalElements;
    }
    notifyListeners();
  }
}