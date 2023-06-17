import 'dart:async';

import 'package:docker_client/models/container_item_service.dart';
import 'package:docker_client/providers/addresses_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Log {
  String? timestamp;
  String? log;
  Log({this.timestamp, this.log});
}

class ContainerLogsProvider extends ChangeNotifier {
  AddressesProvider addressesProvider;
  String? container;
  bool loading = false;
  List<Log> logList = [];
  String tail = '50';
  ScrollController scroll = ScrollController();

  ContainerLogsProvider(this.addressesProvider, this.container) {
    logs();
  }

  Future<void> logs() async {
    if ( this.container != null ) {
      loading = true;
      notifyListeners();
      if ( addressesProvider.usedAddress != null ) {
        String logs =  await ContainerItemService(addressesProvider.usedAddress!).logs(container!, tail);
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
  }

  _scrollToBottom() {
    if (scroll.hasClients && scroll.position.maxScrollExtent > 0) {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(const Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }
}