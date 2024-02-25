import 'package:docker_client/models/container_item.dart';
import 'package:docker_client/models/image-item.dart';
import 'package:http/http.dart' as http;

class DockerService {
  final String url;
  final String client;

  DockerService(this.url, {
    this.client = 'v1.24'
  });

  systemInfo() async {
    Uri uri = Uri.http(url, '/$client/info');
    final res = await http.get( uri );
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

  Future<String> containerLogs(String id, {String tail = '50', DateTime? since, DateTime? until}) async {
    Map<String, dynamic> params = {'stdout': 'true', 'stderr': 'true', 'timestamps': 'true'};
    if ( tail != null) params['tail'] = tail;
    DateTime now = DateTime.now();
    if ( since != null ) {
      params['since'] = since.microsecondsSinceEpoch.toString();
      print(params['since']);
    }
    if ( until != null ) {
      params['until'] = until.toUtc().microsecondsSinceEpoch.toString();
    }
    Uri uri = Uri.http(url, '/$client/containers/$id/logs', params);
    print( uri );
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

  Future<void> removeImage(String id) async {
    Uri uri = Uri.http(url, '/$client/images/$id');
    print( uri );
    final res = await http.delete( uri );
    print(res.body);
  }

  Future<void> pruneImages(bool onlyUntagged) async {
    final params = {
      'dangling': '$onlyUntagged',
    };
    Uri uri = Uri.http(url, '/$client/images/prune', params);
    final res = await http.post( uri );
    print(res.body);
  }
}