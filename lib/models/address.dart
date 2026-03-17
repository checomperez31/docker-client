import 'dart:convert' show json;

class Address {
  String? ip;
  String? name;
  String? client;

  Address({this.ip, this.name, this.client});

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    ip: json['ip'],
    name: json['name'],
    client: json['client'],
  );

  Map<String, dynamic> toJson() => {
    'ip': ip,
    'name': name,
    'client': client,
  };
}