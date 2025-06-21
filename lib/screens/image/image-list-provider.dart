import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ImageListProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  List<ImageItem> elements = [];
  bool loading = false;
  bool loadingDelete = false;
  bool loadingPrune = false;
  bool disposed = false;

  ImageListProvider(this.addressesProvider){
    loadData();
  }

  loadData() async {
    loading = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) elements = await DockerService(addressesProvider.usedAddress!).getImageList();
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
}