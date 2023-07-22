import 'dart:convert';
import 'dart:typed_data';

class ContainerPort {
  String? ip;
  int? private;
  int? public;
  String? type;

  ContainerPort({
    this.ip,
    this.private,
    this.public,
    this.type,
  });

  factory ContainerPort.fromMap(Map<String, dynamic> json) => ContainerPort(
    ip: json['IP'],
    private: json['PrivatePort'],
    public: json['PublicPort'],
    type: json['Type'],
  );

  factory ContainerPort.fromJson(String str) => ContainerPort.fromMap(json.decode( str ));

  static List<ContainerPort> decodeListFromString(Uint8List bytes) {
    return listFromString( utf8.decode( bytes ) );
  }

  static List<ContainerPort> listFromString(String str) {
    return (json.decode( str ) as List).map((e) => ContainerPort.fromMap( e )).toList();
  }

  static List<ContainerPort> listFromList(dynamic str) {
    return (str as List).map((e) => ContainerPort.fromMap( e )).toList();
  }

  @override
  String toString() {
    return 'ContainerPort{ip: $ip, private: $private, public: $public, type: $type}';
  }
}