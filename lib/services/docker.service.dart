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
    print(res.body);
  }
}