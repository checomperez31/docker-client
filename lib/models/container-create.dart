import 'dart:convert';

import 'package:docker_client/models/port.dart' show Port;

class DockerCreate {
  String? name;
  String? image;
  String? imageId;
  List<Port>? exposedPort;
  List<String>? extraHosts;

  DockerCreate({
    this.name,
    this.image,
    this.imageId,
    this.exposedPort,
    this.extraHosts
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    var exposedPorts = {};
    var portsBindings = {};
    if ( exposedPort != null ) {
      for (var port in exposedPort!) {
        exposedPorts.addAll({
          '${port.port}': {}
        });
        portsBindings.addAll({
          '${port.port}': port.mappings != null ? port.mappings!.map((mapping)=> {'HostPort': mapping.hostPort}).toList(): []
        });
      }
    }
    return {
      "Image": image,
      "ExposedPorts": exposedPorts,
      "HostConfig": {
        "ExtraHosts": (extraHosts != null && extraHosts!.isNotEmpty)? extraHosts!.map((port) => port).toList(): [],
        "PortBindings": portsBindings
      },
    };
  }
}
