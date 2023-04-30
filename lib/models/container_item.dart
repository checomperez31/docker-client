import 'dart:convert';
import 'dart:typed_data';

import 'package:docker_client/models/container_port.dart';

class ContainerItem {
  String? id;
  List<String>? names;
  String? image;
  List<ContainerPort>? ports;
  int? created;
  String? state;
  String? status;

  ContainerItem({
    this.id,
    this.names,
    this.image,
    this.ports,
    this.created,
    this.state,
    this.status,
  });

  String simplifiedName() {
    String name = names != null && names!.isNotEmpty ? names![0]: 'NA';
    return name.startsWith('/') ? name.substring(1): name;
  }
  
  String simplifiedId() {
    return id!.substring(0, 12);
  }

  factory ContainerItem.fromMap(Map<String, dynamic> json) => ContainerItem(
    id: json['Id'],
    names: json['Names'] != null?(json['Names'] as List).map((e) => e.toString()).toList(): [],
    image: json['Image'],
    ports: json['Ports'] != null? ContainerPort.listFromList(json['Ports']): [],
    created: json['Created'],
    state: json['State'],
    status: json['Status'],
  );

  factory ContainerItem.fromJson(String str) => ContainerItem.fromMap(json.decode( str ));

  static List<ContainerItem> decodeListFromString(Uint8List bytes) {
    return listFromString( utf8.decode( bytes ) );
  }

  static List<ContainerItem> listFromString(String str) {
    return (json.decode( str ) as List).map((e) => ContainerItem.fromMap( e )).toList();
  }
}