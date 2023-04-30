import 'dart:convert';
import 'dart:typed_data';

class ImageItem {
  String? id;
  String? parentId;
  int? created;
  int? size;
  int? sharedSize;
  int? virtualSize;
  Map<String, dynamic>? labels;
  int? containers;
  List<String>? tags;
  List<String>? digest;

  ImageItem({
    this.id,
    this.parentId,
    this.created,
    this.size,
    this.sharedSize,
    this.virtualSize,
    this.labels,
    this.containers,
    this.tags,
    this.digest
  });

  String simplifiedTag() {
    if ( tags == null || tags!.isEmpty ) return '';
    final parts = tags![0].split(':');
    return parts.isNotEmpty? parts[0]: tags![0];
  }

  factory ImageItem.fromMap(Map<String, dynamic> data) => ImageItem(
    id: data['Id'],
    parentId: data['ParentId'],
    created: data['Created'] != null? int.parse(data['Created'].toString()): null,
    size: data['Size'] != null? int.parse(data['Size'].toString()): null,
    sharedSize: data['SharedSize'] != null? int.parse(data['SharedSize'].toString()): null,
    virtualSize: data['VirtualSize'] != null? int.parse(data['VirtualSize'].toString()): null,
    labels: data['Labels'],
    containers: data['Containers'] != null? int.parse(data['Containers'].toString()): null,
    tags: data['RepoTags'] != null?(data['RepoTags'] as List).map((e) => e.toString()).toList(): [],
    digest: data['RepoDigests'] != null?(data['RepoDigests'] as List).map((e) => e.toString()).toList(): [],
  );

  factory ImageItem.fromJson(String str) => ImageItem.fromMap(json.decode( str ));

  static List<ImageItem> decodeListFromString(Uint8List bytes) {
    return listFromString( utf8.decode( bytes ) );
  }

  static List<ImageItem> listFromString(String str) {
    return (json.decode( str ) as List).map((e) => ImageItem.fromMap( e )).toList();
  }
}