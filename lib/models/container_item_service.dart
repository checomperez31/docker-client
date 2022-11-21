import 'package:docker_client/models/container_item.dart';
import 'package:http/http.dart' as http;

class ContainerItemService {
  Future<List<ContainerItem>> getList() async {
    final res = await http.get(Uri.http('', ''));
    print(res.body);
    return ContainerItem.decodeListFromString(res.bodyBytes);
  }
}