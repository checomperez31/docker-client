import 'dart:convert' show json;

class Port {
  String? port;
  List<PortMapping>? mappings;

  Port({
    this.port,
    this.mappings
  });

  factory Port.fromRawJson(String str) => Port.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Port.fromJson(Map<String, dynamic> json) => Port(
    mappings: json["8104/tcp"] == null ? [] : List<PortMapping>.from(json["8104/tcp"]!.map((x) => PortMapping.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    '$port': mappings == null ? [] : List<dynamic>.from(mappings!.map((x) => x.toJson())),
  };

  static List<Port> fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return [];
    return map.keys.map((key) => Port(
        port: key,
        mappings: map[key] == null? null: List<PortMapping>.from(map[key]!.map((x) => PortMapping.fromJson(x))).toList()
    )).toList();
  }
}

class PortMapping {
  String? hostIp;
  String? hostPort;

  PortMapping({
    this.hostIp,
    this.hostPort,
  });

  factory PortMapping.fromRawJson(String str) => PortMapping.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortMapping.fromJson(Map<String, dynamic> json) => PortMapping(
    hostIp: json["HostIp"],
    hostPort: json["HostPort"],
  );

  Map<String, dynamic> toJson() => {
    "HostIp": hostIp,
    "HostPort": hostPort,
  };
}