import 'dart:convert';
import 'dart:typed_data';

import 'package:docker_client/models/container_port.dart';

class ContainerItem {
  String? id;
  List<String>? names;
  String? image;
  String? imageId;
  List<ContainerPort>? ports;
  int? created;
  int? sizeRw;
  int? sizeRootFs;
  String? state;
  String? status;
  String? address;

  ContainerItem({
    this.id,
    this.names,
    this.image,
    this.imageId,
    this.ports,
    this.created,
    this.sizeRw,
    this.sizeRootFs,
    this.state,
    this.status,
    this.address
  });

  String simplifiedName() {
    String name = names != null && names!.isNotEmpty ? names![0]: 'NA';
    return name.startsWith('/') ? name.substring(1): name;
  }
  
  String simplifiedId() {
    return id!.substring(0, 12);
  }

  String simplifiedPort() {
    return (ports != null && ports!.isNotEmpty) ? ports!.map((e) => e.public?.toString())
        .where((element) => element != null).reduce((value, element) => (value!.isNotEmpty? '$value,': '') + element!)!: 'NA';
  }

  List<String> distinctPorts() {
    if ( ports == null ) return [];
    List<String> portsToReturn = [];
    for (var e in ports!) {
      var data = '${e.public}:${e.private}';
      if ( !portsToReturn.contains(data) ) portsToReturn.add( data );
    }
    return portsToReturn;
  }

  factory ContainerItem.fromMap(Map<String, dynamic> json, {String? address}) => ContainerItem(
    id: json['Id'],
    names: json['Names'] != null?(json['Names'] as List).map((e) => e.toString()).toList(): [],
    image: json['Image'],
    imageId: json['ImageID'],
    ports: json['Ports'] != null? ContainerPort.listFromList(json['Ports']): [],
    created: json['Created'],
    sizeRw: json['SizeRw'],
    sizeRootFs: json['SizeRootFs'],
    state: json['State'],
    status: json['Status'],
    address: address
  );

  factory ContainerItem.fromJson(String str) => ContainerItem.fromMap(json.decode( str ));

  static List<ContainerItem> decodeListFromString(Uint8List bytes, {String? address}) {
    return listFromString( utf8.decode( bytes ), address: address );
  }

  static List<ContainerItem> listFromString(String str, {String? address}) {
    return (json.decode( str ) as List).map((e) => ContainerItem.fromMap( e, address: address )).toList();
  }
}