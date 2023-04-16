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
}