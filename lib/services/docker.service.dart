import 'dart:convert';
import 'package:docker_client/models/container-create.dart';
import 'package:docker_client/models/container-stats.dart';
import 'package:docker_client/models/container.dart';
import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/models/image-item.dart';
import 'package:docker_client/models/system_info.dart';
import 'package:http/http.dart' as http;

class DockerService {
  final String url;
  final String client;

  DockerService(this.url, {
    this.client = 'v1.24'
  });

  Future<SystemInfo> systemInfo() async {
    Uri uri = Uri.http(url, '/$client/info');
    final res = await http.get( uri );
    return SystemInfo.fromJson( utf8.decode( res.bodyBytes ) );
  }

  Future<List<ContainerItem>> getContainerList() async {
    Uri uri = Uri.http(url, '/$client/containers/json', {'all': 'true'});
    print( uri );
    try {
      final res = await http.get( uri );
      return ContainerItem.decodeListFromString(res.bodyBytes, address: url);
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<DockerContainer?> getContainerInfo(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id/json');
    print( uri );
    try {
      final res = await http.get( uri );
      return DockerContainer.fromRawJson(utf8.decode( res.bodyBytes ));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ContainerStats?> getContainerStats(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id/stats', {'stream': 'false'});
    print( uri );
    try {
      final res = await http.get( uri );
      return ContainerStats.fromRawJson(utf8.decode( res.bodyBytes ));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> restartContainer(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id/restart');
    print( uri );
    await http.post( uri );
  }

  Future<void> stopContainer(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id/stop');
    print( uri );
    await http.post( uri );
  }

  Future<void> startContainer(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id/start');
    print( uri );
    await http.post( uri );
  }

  Future<void> removeContainer(String id) async {
    Uri uri = Uri.http(url, '/$client/containers/$id');
    print( uri );
    await http.delete( uri );
  }

  Future<String> containerLogs(String id, {String tail = '50', DateTime? since, DateTime? until, bool timestamps = false}) async {
    Map<String, dynamic> params = {'stdout': 'true', 'stderr': 'true', 'timestamps': '$timestamps'};
    params['tail'] = tail;
    DateTime now = DateTime.now();
    if ( since != null ) {
      params['since'] = since.microsecondsSinceEpoch.toString();
      print(params['since']);
    }
    if ( until != null ) {
      params['until'] = until.toUtc().microsecondsSinceEpoch.toString();
    }
    Uri uri = Uri.http(url, '/$client/containers/$id/logs', params);
    final res = await http.get( uri );
    return res.body;
  }

  Future<List<ImageItem>> getImageList() async {
    final params = {
      'all': 'true',
      'digests': 'true',
    };
    Uri uri = Uri.http(url, '/$client/images/json', params);
    print( uri );
    try {
      final res = await http.get( uri );
      return ImageItem.decodeListFromString(res.bodyBytes);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> removeImage(String id) async {
    Uri uri = Uri.http(url, '/$client/images/$id');
    print( uri );
    final res = await http.delete( uri );
    if ( res.statusCode == 200 ) {
      var response = json.decode(res.body);
      return List<dynamic>.from(response.map((x) => x)).length;
    }
    throw Exception(res.body);
  }

  Future<void> pruneImages(bool onlyUntagged) async {
    final params = {
      'dangling': '$onlyUntagged',
    };
    Uri uri = Uri.http(url, '/$client/images/prune', params);
    final res = await http.post( uri );
    print(res.body);
  }

  Future<dynamic> createContainer(DockerCreate entity) async {
    final params = {
      'name': entity.name!.startsWith('/')? entity.name!.substring(1):entity.name,
    };
    Uri uri = Uri.http(url, '/$client/containers/create', params);
    var body = json.encode( entity.toJson() );
    final res = await http.post( uri, body: body, headers: {'Content-Type': 'application/json'} );
    if ( res.statusCode == 201 ) return json.decode(res.body);
  }
}