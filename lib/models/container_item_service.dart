import 'package:docker_client/models/container_item.dart';
import 'package:http/http.dart' as http;

class ContainerItemService {
  Future<List<ContainerItem>> getList() async {
    Uri uri = Uri.http('localhost:2375', '/v1.24/containers/json', {'all': 'true'});
    print( uri );
    final res = await http.get( uri );
    print(res.body);
    return ContainerItem.decodeListFromString(res.bodyBytes);
  }

  Future<void> restart(String id) async {
    Uri uri = Uri.http('localhost:2375', '/v1.24/containers/$id/restart');
    print( uri );
    final res = await http.post( uri );
    print(res.body);
  }

  Future<void> stop(String id) async {
    Uri uri = Uri.http('localhost:2375', '/v1.24/containers/$id/stop');
    print( uri );
    final res = await http.post( uri );
    print(res.body);
  }

  Future<void> remove(String id) async {
    Uri uri = Uri.http('localhost:2375', '/v1.24/containers/$id');
    print( uri );
    final res = await http.delete( uri );
    print(res.body);
  }
}