import 'package:docker_client/models/system_info.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InfoCardsProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  bool loading = false;
  SystemInfo? info;

  InfoCardsProvider(this.addressesProvider) {
    loadData();
    addressesProvider.addListener(loadData);
  }

  loadData() async {
    loading = true;
    notifyListeners();
    try {
      if ( addressesProvider.usedAddress != null ) {
        info = await DockerService(addressesProvider.usedAddress!).systemInfo();
      }
    } catch (e) {
      print(e);
    }
    loading = false;
    notifyListeners();
  }
}