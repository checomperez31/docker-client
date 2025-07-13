import 'dart:async';

import 'package:docker_client/models/container-stats.dart';
import 'package:docker_client/models/container.dart';
import 'package:docker_client/providers/containers_provider.dart' show ContainersProvider;
import 'package:docker_client/services/docker.service.dart' show DockerService;
import 'package:flutter/foundation.dart';

class ContainerOverviewProvider extends ChangeNotifier {
  ContainersProvider containersProvider;
  bool loading = false;
  DockerContainer? entity;
  ContainerStats? entityStats;

  ContainerOverviewProvider(this.containersProvider) {
    containersProvider.addListener(updateData);
    getData();
    getStats();
  }

  @override
  void dispose() {
    containersProvider.removeListener(updateData);
    super.dispose();
  }

  Future<void> getData() async {
    loading = true;
    notifyListeners();
    if ( containersProvider.selected != null ) {
      entity = await DockerService( containersProvider.selected!.address! ).getContainerInfo(containersProvider.selected!.id!);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> getStats() async {
    loading = true;
    notifyListeners();
    if ( containersProvider.selected != null ) {
      entityStats = await DockerService( containersProvider.selected!.address! ).getContainerStats(containersProvider.selected!.id!);
    }
    loading = false;
    notifyListeners();
  }

  void updateData() {
    getData();
    getStats();
  }
}