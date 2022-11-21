import 'dart:convert';
import 'dart:typed_data';

class ContainerItem {
  String? id;
  List<String>? names;
  String? image;

  ContainerItem({
    this.id,
    this.names,
    this.image
  });

  factory ContainerItem.fromMap(Map<String, dynamic> json) => ContainerItem(
    id: json['Id'],
    names: json['Names'] != null?(json['Names'] as List).map((e) => e.toString()).toList(): [],
    image: json['Image'],
  );

  factory ContainerItem.fromJson(String str) => ContainerItem.fromMap(json.decode( str ));

  static List<ContainerItem> decodeListFromString(Uint8List bytes) {
    return listFromString( utf8.decode( bytes ) );
  }

  static List<ContainerItem> listFromString(String str) {
    return (json.decode( str ) as List).map((e) => ContainerItem.fromMap( e )).toList();
  }
}