import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:docker_client/providers/containers_provider.dart';
import 'package:docker_client/models/container_item_service.dart';

class Log {
  String? timestamp;
  String? log;
  Log({this.timestamp, this.log});
}

class ContainerLogsProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  ContainersProvider containersProvider;
  bool loading = false;
  List<Log> logList = [];
  String tail = '50';
  DateTime? since;
  DateTime? until;
  ScrollController scroll = ScrollController();

  ContainerLogsProvider(this.addressesProvider, this.containersProvider) {
    containersProvider.addListener(updateData);
    logs();
  }

  @override
  void dispose() {
    containersProvider.removeListener(updateData);
    super.dispose();
  }

  Future<void> logs() async {
    loading = true;
    notifyListeners();
    if ( addressesProvider.usedAddress != null ) {
      String logs =  await ContainerItemService(addressesProvider.usedAddress!).logs(containersProvider.selected!.id!, tail: tail, since: since, until: until);
      List<String> list = logs.split('\n').map((e) => e.length > 8? e.substring(8): e).toList();
      logList = list.map((e) {
        if (e.length >= 30 && e.substring(29, 30) == 'Z') {
          try {
            return Log(timestamp: e.substring(1, 29), log: e.substring(30));
          } catch(e) {
            print(e);
          }
        }
        return Log(log: e);
      }).toList();
    }
    loading = false;
    notifyListeners();
    _scrollToBottom();
  }

  _scrollToBottom() {
    if (scroll.hasClients && scroll.position.maxScrollExtent > 0) {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(const Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  updateData() {
    logs();
  }
}