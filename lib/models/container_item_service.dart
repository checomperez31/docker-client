import 'dart:convert';

import 'package:docker_client/models/container_item.dart';
import 'package:http/http.dart' as http;

class ContainerItemService {
  String url;

  ContainerItemService(this.url);

  Future<List<ContainerItem>> getList() async {
    Uri uri = Uri.http(url, '/v1.24/containers/json', {'all': 'true'});
    print( uri );
    final res = await http.get( uri );
    print(res.body);
    return ContainerItem.decodeListFromString(res.bodyBytes);
  }

  Future<void> restart(String id) async {
    Uri uri = Uri.http(url, '/v1.24/containers/$id/restart');
    print( uri );
    final res = await http.post( uri );
    print(res.body);
  }

  Future<void> stop(String id) async {
    Uri uri = Uri.http(url, '/v1.24/containers/$id/stop');
    print( uri );
    final res = await http.post( uri );
    print(res.body);
  }

  Future<void> start(String id) async {
    Uri uri = Uri.http(url, '/v1.24/containers/$id/start');
    print( uri );
    final res = await http.post( uri );
    print(res.body);
  }

  Future<void> remove(String id) async {
    Uri uri = Uri.http(url, '/v1.24/containers/$id');
    print( uri );
    final res = await http.delete( uri );
    print(res.body);
  }

  Future<String> logs(String id, String tail) async {
    Uri uri = Uri.http(url, '/v1.24/containers/$id/logs', {'tail': tail, 'stdout': 'true', 'timestamps': 'true'});
    print( uri );
    final res = await http.get( uri );
    return res.body;
  }
}