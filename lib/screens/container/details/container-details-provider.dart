import 'dart:async';

import 'package:docker_client/services/docker.service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:docker_client/providers/containers_provider.dart';

class ContainerDetailsProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }
}