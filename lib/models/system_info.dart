import 'dart:convert';
import 'dart:typed_data';

class SystemInfo {
  String? id;
  int? containers;
  int? containersRunning;
  int? containersPaused;
  int? containersStopped;
  int? images;
  String? architecture;
  String? osType;
  String? os;
  int? cores;
  int? memory;

  SystemInfo({
    this.id,
    this.containers,
    this.containersRunning,
    this.containersPaused,
    this.containersStopped,
    this.images,
    this.architecture,
    this.osType,
    this.os,
    this.cores,
    this.memory
  });

  factory SystemInfo.fromMap(Map<String, dynamic> json, {String? address}) => SystemInfo(
      id: json['ID'],
      containers: json['Containers'],
      containersRunning: json['ContainersRunning'],
      containersPaused: json['ContainersPaused'],
      containersStopped: json['ContainersStopped'],
      images: json['Images'],
      architecture: json['Architecture'],
      osType: json['OSType'],
      os: json['OperatingSystem'],
      cores: json['NCPU'],
      memory: json['MemTotal'],
  );

  factory SystemInfo.fromJson(String str) => SystemInfo.fromMap(json.decode( str ));

  static List<SystemInfo> decodeListFromString(Uint8List bytes, {String? address}) {
    return listFromString( utf8.decode( bytes ), address: address );
  }

  static List<SystemInfo> listFromString(String str, {String? address}) {
    return (json.decode( str ) as List).map((e) => SystemInfo.fromMap( e, address: address )).toList();
  }

  String calculatedMemory() {
    if (memory == null || memory == 0) return '0 bytes';
    double kb = memory! / 1024;
    if (kb < 1) return '${memory!.toStringAsFixed(2)} bytes';
    double mb = kb / 1024;
    if (mb < 1) return '${kb.toStringAsFixed(2)} KB';
    double gb = mb / 1024;
    if (gb < 1) return '${mb.toStringAsFixed(2)} MB';
    double tb = gb / 1024;
    if (tb < 1) return '${gb.toStringAsFixed(2)} GB';
    return '$tb TB';
  }
}