import 'package:docker_client/models/image-item-service.dart';
import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/providers/addresses_provider.dart';
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
    if ( addressesProvider.usedAddress != null ) elements = await ImageItemService(addressesProvider.usedAddress!).getList();
    loading = false;
    notifyListeners();
  }

  remove(String id) async {
    loadingDelete = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ImageItemService(addressesProvider.usedAddress!).remove(id);
    loadingDelete = false;
    await loadData();
  }

  prune() async {
    loadingPrune = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) await ImageItemService(addressesProvider.usedAddress!).prune(true);
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