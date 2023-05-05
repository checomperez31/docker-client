import 'package:docker_client/models/image-item.dart';
import 'package:http/http.dart' as http;

class ImageItemService {
  String url;

  ImageItemService(this.url);

  Future<List<ImageItem>> getList() async {
    final params = {
      'all': 'true',
      'digests': 'true',
    };
    Uri uri = Uri.http(url, '/v1.24/images/json', params);
    print( uri );
    final res = await http.get( uri );
    print(res.body);
    return ImageItem.decodeListFromString(res.bodyBytes);
  }

  Future<void> remove(String id) async {
    Uri uri = Uri.http(url, '/v1.24/images/$id');
    print( uri );
    final res = await http.delete( uri );
    print(res.body);
  }

  Future<void> prune(bool onlyUntagged) async {
    final params = {
      'dangling': '$onlyUntagged',
    };
    Uri uri = Uri.http(url, '/v1.24/images/prune', params);
    final res = await http.post( uri );
    print(res.body);
  }
}