import 'dart:convert' show json;

class Address {
  String? ip;
  String? name;

  Address({this.ip, this.name});

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    ip: json['ip'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'ip': ip,
    'name': name
  };
}