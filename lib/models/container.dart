import 'dart:convert';
import 'dart:typed_data';

import 'package:docker_client/models/container_port.dart';

// To parse this JSON data, do
//
//     final container = containerFromJson(jsonString);

import 'dart:convert';

import 'dart:convert';

class Container {
  String? id;
  DateTime? created;
  String? path;
  List<String>? args;
  State? state;
  String? image;
  String? resolvConfPath;
  String? hostnamePath;
  String? hostsPath;
  String? logPath;
  String? name;
  int? restartCount;
  String? driver;
  String? platform;
  String? mountLabel;
  String? processLabel;
  String? appArmorProfile;
  dynamic execIDs;
  HostConfig? hostConfig;
  GraphDriver? graphDriver;
  List<dynamic>? mounts;
  Config? config;
  NetworkSettings? networkSettings;

  Container({
    this.id,
    this.created,
    this.path,
    this.args,
    this.state,
    this.image,
    this.resolvConfPath,
    this.hostnamePath,
    this.hostsPath,
    this.logPath,
    this.name,
    this.restartCount,
    this.driver,
    this.platform,
    this.mountLabel,
    this.processLabel,
    this.appArmorProfile,
    this.execIDs,
    this.hostConfig,
    this.graphDriver,
    this.mounts,
    this.config,
    this.networkSettings,
  });

  factory Container.fromRawJson(String str) => Container.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Container.fromJson(Map<String, dynamic> json) => Container(
    id: json["Id"],
    created: json["Created"] == null ? null : DateTime.parse(json["Created"]),
    path: json["Path"],
    args: json["Args"] == null ? [] : List<String>.from(json["Args"]!.map((x) => x)),
    state: json["State"] == null ? null : State.fromJson(json["State"]),
    image: json["Image"],
    resolvConfPath: json["ResolvConfPath"],
    hostnamePath: json["HostnamePath"],
    hostsPath: json["HostsPath"],
    logPath: json["LogPath"],
    name: json["Name"],
    restartCount: json["RestartCount"],
    driver: json["Driver"],
    platform: json["Platform"],
    mountLabel: json["MountLabel"],
    processLabel: json["ProcessLabel"],
    appArmorProfile: json["AppArmorProfile"],
    execIDs: json["ExecIDs"],
    hostConfig: json["HostConfig"] == null ? null : HostConfig.fromJson(json["HostConfig"]),
    graphDriver: json["GraphDriver"] == null ? null : GraphDriver.fromJson(json["GraphDriver"]),
    mounts: json["Mounts"] == null ? [] : List<dynamic>.from(json["Mounts"]!.map((x) => x)),
    config: json["Config"] == null ? null : Config.fromJson(json["Config"]),
    networkSettings: json["NetworkSettings"] == null ? null : NetworkSettings.fromJson(json["NetworkSettings"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Created": created?.toIso8601String(),
    "Path": path,
    "Args": args == null ? [] : List<dynamic>.from(args!.map((x) => x)),
    "State": state?.toJson(),
    "Image": image,
    "ResolvConfPath": resolvConfPath,
    "HostnamePath": hostnamePath,
    "HostsPath": hostsPath,
    "LogPath": logPath,
    "Name": name,
    "RestartCount": restartCount,
    "Driver": driver,
    "Platform": platform,
    "MountLabel": mountLabel,
    "ProcessLabel": processLabel,
    "AppArmorProfile": appArmorProfile,
    "ExecIDs": execIDs,
    "HostConfig": hostConfig?.toJson(),
    "GraphDriver": graphDriver?.toJson(),
    "Mounts": mounts == null ? [] : List<dynamic>.from(mounts!.map((x) => x)),
    "Config": config?.toJson(),
    "NetworkSettings": networkSettings?.toJson(),
  };

  @override
  String toString() {
    return 'Container{id: $id, created: $created, path: $path, args: $args, state: $state, image: $image, resolvConfPath: $resolvConfPath, hostnamePath: $hostnamePath, hostsPath: $hostsPath, logPath: $logPath, name: $name, restartCount: $restartCount, driver: $driver, platform: $platform, mountLabel: $mountLabel, processLabel: $processLabel, appArmorProfile: $appArmorProfile, execIDs: $execIDs, hostConfig: $hostConfig, graphDriver: $graphDriver, mounts: $mounts, config: $config, networkSettings: $networkSettings}';
  }
}

class Config {
  String? hostname;
  String? domainname;
  String? user;
  bool? attachStdin;
  bool? attachStdout;
  bool? attachStderr;
  ExposedPorts? exposedPorts;
  bool? tty;
  bool? openStdin;
  bool? stdinOnce;
  List<String>? env;
  dynamic cmd;
  String? image;
  dynamic volumes;
  String? workingDir;
  List<String>? entrypoint;
  dynamic onBuild;
  Labels? labels;

  Config({
    this.hostname,
    this.domainname,
    this.user,
    this.attachStdin,
    this.attachStdout,
    this.attachStderr,
    this.exposedPorts,
    this.tty,
    this.openStdin,
    this.stdinOnce,
    this.env,
    this.cmd,
    this.image,
    this.volumes,
    this.workingDir,
    this.entrypoint,
    this.onBuild,
    this.labels,
  });

  factory Config.fromRawJson(String str) => Config.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    hostname: json["Hostname"],
    domainname: json["Domainname"],
    user: json["User"],
    attachStdin: json["AttachStdin"],
    attachStdout: json["AttachStdout"],
    attachStderr: json["AttachStderr"],
    exposedPorts: json["ExposedPorts"] == null ? null : ExposedPorts.fromJson(json["ExposedPorts"]),
    tty: json["Tty"],
    openStdin: json["OpenStdin"],
    stdinOnce: json["StdinOnce"],
    env: json["Env"] == null ? [] : List<String>.from(json["Env"]!.map((x) => x)),
    cmd: json["Cmd"],
    image: json["Image"],
    volumes: json["Volumes"],
    workingDir: json["WorkingDir"],
    entrypoint: json["Entrypoint"] == null ? [] : List<String>.from(json["Entrypoint"]!.map((x) => x)),
    onBuild: json["OnBuild"],
    labels: json["Labels"] == null ? null : Labels.fromJson(json["Labels"]),
  );

  Map<String, dynamic> toJson() => {
    "Hostname": hostname,
    "Domainname": domainname,
    "User": user,
    "AttachStdin": attachStdin,
    "AttachStdout": attachStdout,
    "AttachStderr": attachStderr,
    "ExposedPorts": exposedPorts?.toJson(),
    "Tty": tty,
    "OpenStdin": openStdin,
    "StdinOnce": stdinOnce,
    "Env": env == null ? [] : List<dynamic>.from(env!.map((x) => x)),
    "Cmd": cmd,
    "Image": image,
    "Volumes": volumes,
    "WorkingDir": workingDir,
    "Entrypoint": entrypoint == null ? [] : List<dynamic>.from(entrypoint!.map((x) => x)),
    "OnBuild": onBuild,
    "Labels": labels?.toJson(),
  };
}

class ExposedPorts {
  Labels? the8104Tcp;

  ExposedPorts({
    this.the8104Tcp,
  });

  factory ExposedPorts.fromRawJson(String str) => ExposedPorts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExposedPorts.fromJson(Map<String, dynamic> json) => ExposedPorts(
    the8104Tcp: json["8104/tcp"] == null ? null : Labels.fromJson(json["8104/tcp"]),
  );

  Map<String, dynamic> toJson() => {
    "8104/tcp": the8104Tcp?.toJson(),
  };
}

class Labels {
  Labels();

  factory Labels.fromRawJson(String str) => Labels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Labels.fromJson(Map<String, dynamic> json) => Labels(
  );

  Map<String, dynamic> toJson() => {
  };
}

class GraphDriver {
  Data? data;
  String? name;

  GraphDriver({
    this.data,
    this.name,
  });

  factory GraphDriver.fromRawJson(String str) => GraphDriver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GraphDriver.fromJson(Map<String, dynamic> json) => GraphDriver(
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
    "Name": name,
  };
}

class Data {
  String? id;
  String? lowerDir;
  String? mergedDir;
  String? upperDir;
  String? workDir;

  Data({
    this.id,
    this.lowerDir,
    this.mergedDir,
    this.upperDir,
    this.workDir,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    lowerDir: json["LowerDir"],
    mergedDir: json["MergedDir"],
    upperDir: json["UpperDir"],
    workDir: json["WorkDir"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "LowerDir": lowerDir,
    "MergedDir": mergedDir,
    "UpperDir": upperDir,
    "WorkDir": workDir,
  };
}

class HostConfig {
  dynamic binds;
  String? containerIdFile;
  LogConfig? logConfig;
  String? networkMode;
  Port? portBindings;
  RestartPolicy? restartPolicy;
  bool? autoRemove;
  String? volumeDriver;
  dynamic volumesFrom;
  List<int>? consoleSize;
  dynamic capAdd;
  dynamic capDrop;
  String? cgroupnsMode;
  List<dynamic>? dns;
  List<dynamic>? dnsOptions;
  List<dynamic>? dnsSearch;
  dynamic extraHosts;
  dynamic groupAdd;
  String? ipcMode;
  String? cgroup;
  dynamic links;
  int? oomScoreAdj;
  String? pidMode;
  bool? privileged;
  bool? publishAllPorts;
  bool? readonlyRootfs;
  dynamic securityOpt;
  String? utsMode;
  String? usernsMode;
  int? shmSize;
  String? runtime;
  String? isolation;
  int? cpuShares;
  int? memory;
  int? nanoCpus;
  String? cgroupParent;
  int? blkioWeight;
  List<dynamic>? blkioWeightDevice;
  List<dynamic>? blkioDeviceReadBps;
  List<dynamic>? blkioDeviceWriteBps;
  List<dynamic>? blkioDeviceReadIOps;
  List<dynamic>? blkioDeviceWriteIOps;
  int? cpuPeriod;
  int? cpuQuota;
  int? cpuRealtimePeriod;
  int? cpuRealtimeRuntime;
  String? cpusetCpus;
  String? cpusetMems;
  List<dynamic>? devices;
  dynamic deviceCgroupRules;
  dynamic deviceRequests;
  int? memoryReservation;
  int? memorySwap;
  dynamic memorySwappiness;
  dynamic oomKillDisable;
  dynamic pidsLimit;
  List<dynamic>? ulimits;
  int? cpuCount;
  int? cpuPercent;
  int? ioMaximumIOps;
  int? ioMaximumBandwidth;
  List<String>? maskedPaths;
  List<String>? readonlyPaths;

  HostConfig({
    this.binds,
    this.containerIdFile,
    this.logConfig,
    this.networkMode,
    this.portBindings,
    this.restartPolicy,
    this.autoRemove,
    this.volumeDriver,
    this.volumesFrom,
    this.consoleSize,
    this.capAdd,
    this.capDrop,
    this.cgroupnsMode,
    this.dns,
    this.dnsOptions,
    this.dnsSearch,
    this.extraHosts,
    this.groupAdd,
    this.ipcMode,
    this.cgroup,
    this.links,
    this.oomScoreAdj,
    this.pidMode,
    this.privileged,
    this.publishAllPorts,
    this.readonlyRootfs,
    this.securityOpt,
    this.utsMode,
    this.usernsMode,
    this.shmSize,
    this.runtime,
    this.isolation,
    this.cpuShares,
    this.memory,
    this.nanoCpus,
    this.cgroupParent,
    this.blkioWeight,
    this.blkioWeightDevice,
    this.blkioDeviceReadBps,
    this.blkioDeviceWriteBps,
    this.blkioDeviceReadIOps,
    this.blkioDeviceWriteIOps,
    this.cpuPeriod,
    this.cpuQuota,
    this.cpuRealtimePeriod,
    this.cpuRealtimeRuntime,
    this.cpusetCpus,
    this.cpusetMems,
    this.devices,
    this.deviceCgroupRules,
    this.deviceRequests,
    this.memoryReservation,
    this.memorySwap,
    this.memorySwappiness,
    this.oomKillDisable,
    this.pidsLimit,
    this.ulimits,
    this.cpuCount,
    this.cpuPercent,
    this.ioMaximumIOps,
    this.ioMaximumBandwidth,
    this.maskedPaths,
    this.readonlyPaths,
  });

  factory HostConfig.fromRawJson(String str) => HostConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HostConfig.fromJson(Map<String, dynamic> json) => HostConfig(
    binds: json["Binds"],
    containerIdFile: json["ContainerIDFile"],
    logConfig: json["LogConfig"] == null ? null : LogConfig.fromJson(json["LogConfig"]),
    networkMode: json["NetworkMode"],
    portBindings: json["PortBindings"] == null ? null : Port.fromJson(json["PortBindings"]),
    restartPolicy: json["RestartPolicy"] == null ? null : RestartPolicy.fromJson(json["RestartPolicy"]),
    autoRemove: json["AutoRemove"],
    volumeDriver: json["VolumeDriver"],
    volumesFrom: json["VolumesFrom"],
    consoleSize: json["ConsoleSize"] == null ? [] : List<int>.from(json["ConsoleSize"]!.map((x) => x)),
    capAdd: json["CapAdd"],
    capDrop: json["CapDrop"],
    cgroupnsMode: json["CgroupnsMode"],
    dns: json["Dns"] == null ? [] : List<dynamic>.from(json["Dns"]!.map((x) => x)),
    dnsOptions: json["DnsOptions"] == null ? [] : List<dynamic>.from(json["DnsOptions"]!.map((x) => x)),
    dnsSearch: json["DnsSearch"] == null ? [] : List<dynamic>.from(json["DnsSearch"]!.map((x) => x)),
    extraHosts: json["ExtraHosts"],
    groupAdd: json["GroupAdd"],
    ipcMode: json["IpcMode"],
    cgroup: json["Cgroup"],
    links: json["Links"],
    oomScoreAdj: json["OomScoreAdj"],
    pidMode: json["PidMode"],
    privileged: json["Privileged"],
    publishAllPorts: json["PublishAllPorts"],
    readonlyRootfs: json["ReadonlyRootfs"],
    securityOpt: json["SecurityOpt"],
    utsMode: json["UTSMode"],
    usernsMode: json["UsernsMode"],
    shmSize: json["ShmSize"],
    runtime: json["Runtime"],
    isolation: json["Isolation"],
    cpuShares: json["CpuShares"],
    memory: json["Memory"],
    nanoCpus: json["NanoCpus"],
    cgroupParent: json["CgroupParent"],
    blkioWeight: json["BlkioWeight"],
    blkioWeightDevice: json["BlkioWeightDevice"] == null ? [] : List<dynamic>.from(json["BlkioWeightDevice"]!.map((x) => x)),
    blkioDeviceReadBps: json["BlkioDeviceReadBps"] == null ? [] : List<dynamic>.from(json["BlkioDeviceReadBps"]!.map((x) => x)),
    blkioDeviceWriteBps: json["BlkioDeviceWriteBps"] == null ? [] : List<dynamic>.from(json["BlkioDeviceWriteBps"]!.map((x) => x)),
    blkioDeviceReadIOps: json["BlkioDeviceReadIOps"] == null ? [] : List<dynamic>.from(json["BlkioDeviceReadIOps"]!.map((x) => x)),
    blkioDeviceWriteIOps: json["BlkioDeviceWriteIOps"] == null ? [] : List<dynamic>.from(json["BlkioDeviceWriteIOps"]!.map((x) => x)),
    cpuPeriod: json["CpuPeriod"],
    cpuQuota: json["CpuQuota"],
    cpuRealtimePeriod: json["CpuRealtimePeriod"],
    cpuRealtimeRuntime: json["CpuRealtimeRuntime"],
    cpusetCpus: json["CpusetCpus"],
    cpusetMems: json["CpusetMems"],
    devices: json["Devices"] == null ? [] : List<dynamic>.from(json["Devices"]!.map((x) => x)),
    deviceCgroupRules: json["DeviceCgroupRules"],
    deviceRequests: json["DeviceRequests"],
    memoryReservation: json["MemoryReservation"],
    memorySwap: json["MemorySwap"],
    memorySwappiness: json["MemorySwappiness"],
    oomKillDisable: json["OomKillDisable"],
    pidsLimit: json["PidsLimit"],
    ulimits: json["Ulimits"] == null ? [] : List<dynamic>.from(json["Ulimits"]!.map((x) => x)),
    cpuCount: json["CpuCount"],
    cpuPercent: json["CpuPercent"],
    ioMaximumIOps: json["IOMaximumIOps"],
    ioMaximumBandwidth: json["IOMaximumBandwidth"],
    maskedPaths: json["MaskedPaths"] == null ? [] : List<String>.from(json["MaskedPaths"]!.map((x) => x)),
    readonlyPaths: json["ReadonlyPaths"] == null ? [] : List<String>.from(json["ReadonlyPaths"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Binds": binds,
    "ContainerIDFile": containerIdFile,
    "LogConfig": logConfig?.toJson(),
    "NetworkMode": networkMode,
    "PortBindings": portBindings?.toJson(),
    "RestartPolicy": restartPolicy?.toJson(),
    "AutoRemove": autoRemove,
    "VolumeDriver": volumeDriver,
    "VolumesFrom": volumesFrom,
    "ConsoleSize": consoleSize == null ? [] : List<dynamic>.from(consoleSize!.map((x) => x)),
    "CapAdd": capAdd,
    "CapDrop": capDrop,
    "CgroupnsMode": cgroupnsMode,
    "Dns": dns == null ? [] : List<dynamic>.from(dns!.map((x) => x)),
    "DnsOptions": dnsOptions == null ? [] : List<dynamic>.from(dnsOptions!.map((x) => x)),
    "DnsSearch": dnsSearch == null ? [] : List<dynamic>.from(dnsSearch!.map((x) => x)),
    "ExtraHosts": extraHosts,
    "GroupAdd": groupAdd,
    "IpcMode": ipcMode,
    "Cgroup": cgroup,
    "Links": links,
    "OomScoreAdj": oomScoreAdj,
    "PidMode": pidMode,
    "Privileged": privileged,
    "PublishAllPorts": publishAllPorts,
    "ReadonlyRootfs": readonlyRootfs,
    "SecurityOpt": securityOpt,
    "UTSMode": utsMode,
    "UsernsMode": usernsMode,
    "ShmSize": shmSize,
    "Runtime": runtime,
    "Isolation": isolation,
    "CpuShares": cpuShares,
    "Memory": memory,
    "NanoCpus": nanoCpus,
    "CgroupParent": cgroupParent,
    "BlkioWeight": blkioWeight,
    "BlkioWeightDevice": blkioWeightDevice == null ? [] : List<dynamic>.from(blkioWeightDevice!.map((x) => x)),
    "BlkioDeviceReadBps": blkioDeviceReadBps == null ? [] : List<dynamic>.from(blkioDeviceReadBps!.map((x) => x)),
    "BlkioDeviceWriteBps": blkioDeviceWriteBps == null ? [] : List<dynamic>.from(blkioDeviceWriteBps!.map((x) => x)),
    "BlkioDeviceReadIOps": blkioDeviceReadIOps == null ? [] : List<dynamic>.from(blkioDeviceReadIOps!.map((x) => x)),
    "BlkioDeviceWriteIOps": blkioDeviceWriteIOps == null ? [] : List<dynamic>.from(blkioDeviceWriteIOps!.map((x) => x)),
    "CpuPeriod": cpuPeriod,
    "CpuQuota": cpuQuota,
    "CpuRealtimePeriod": cpuRealtimePeriod,
    "CpuRealtimeRuntime": cpuRealtimeRuntime,
    "CpusetCpus": cpusetCpus,
    "CpusetMems": cpusetMems,
    "Devices": devices == null ? [] : List<dynamic>.from(devices!.map((x) => x)),
    "DeviceCgroupRules": deviceCgroupRules,
    "DeviceRequests": deviceRequests,
    "MemoryReservation": memoryReservation,
    "MemorySwap": memorySwap,
    "MemorySwappiness": memorySwappiness,
    "OomKillDisable": oomKillDisable,
    "PidsLimit": pidsLimit,
    "Ulimits": ulimits == null ? [] : List<dynamic>.from(ulimits!.map((x) => x)),
    "CpuCount": cpuCount,
    "CpuPercent": cpuPercent,
    "IOMaximumIOps": ioMaximumIOps,
    "IOMaximumBandwidth": ioMaximumBandwidth,
    "MaskedPaths": maskedPaths == null ? [] : List<dynamic>.from(maskedPaths!.map((x) => x)),
    "ReadonlyPaths": readonlyPaths == null ? [] : List<dynamic>.from(readonlyPaths!.map((x) => x)),
  };
}

class LogConfig {
  String? type;
  Labels? config;

  LogConfig({
    this.type,
    this.config,
  });

  factory LogConfig.fromRawJson(String str) => LogConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogConfig.fromJson(Map<String, dynamic> json) => LogConfig(
    type: json["Type"],
    config: json["Config"] == null ? null : Labels.fromJson(json["Config"]),
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
    "Config": config?.toJson(),
  };
}

class Port {
  List<The8104Tcp>? the8104Tcp;

  Port({
    this.the8104Tcp,
  });

  factory Port.fromRawJson(String str) => Port.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Port.fromJson(Map<String, dynamic> json) => Port(
    the8104Tcp: json["8104/tcp"] == null ? [] : List<The8104Tcp>.from(json["8104/tcp"]!.map((x) => The8104Tcp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "8104/tcp": the8104Tcp == null ? [] : List<dynamic>.from(the8104Tcp!.map((x) => x.toJson())),
  };
}

class The8104Tcp {
  String? hostIp;
  String? hostPort;

  The8104Tcp({
    this.hostIp,
    this.hostPort,
  });

  factory The8104Tcp.fromRawJson(String str) => The8104Tcp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory The8104Tcp.fromJson(Map<String, dynamic> json) => The8104Tcp(
    hostIp: json["HostIp"],
    hostPort: json["HostPort"],
  );

  Map<String, dynamic> toJson() => {
    "HostIp": hostIp,
    "HostPort": hostPort,
  };
}

class RestartPolicy {
  String? name;
  int? maximumRetryCount;

  RestartPolicy({
    this.name,
    this.maximumRetryCount,
  });

  factory RestartPolicy.fromRawJson(String str) => RestartPolicy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestartPolicy.fromJson(Map<String, dynamic> json) => RestartPolicy(
    name: json["Name"],
    maximumRetryCount: json["MaximumRetryCount"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "MaximumRetryCount": maximumRetryCount,
  };
}

class NetworkSettings {
  String? bridge;
  String? sandboxId;
  String? sandboxKey;
  Port? ports;
  bool? hairpinMode;
  String? linkLocalIPv6Address;
  int? linkLocalIPv6PrefixLen;
  dynamic secondaryIpAddresses;
  dynamic secondaryIPv6Addresses;
  String? endpointId;
  String? gateway;
  String? globalIPv6Address;
  int? globalIPv6PrefixLen;
  String? ipAddress;
  int? ipPrefixLen;
  String? iPv6Gateway;
  String? macAddress;
  Networks? networks;

  NetworkSettings({
    this.bridge,
    this.sandboxId,
    this.sandboxKey,
    this.ports,
    this.hairpinMode,
    this.linkLocalIPv6Address,
    this.linkLocalIPv6PrefixLen,
    this.secondaryIpAddresses,
    this.secondaryIPv6Addresses,
    this.endpointId,
    this.gateway,
    this.globalIPv6Address,
    this.globalIPv6PrefixLen,
    this.ipAddress,
    this.ipPrefixLen,
    this.iPv6Gateway,
    this.macAddress,
    this.networks,
  });

  factory NetworkSettings.fromRawJson(String str) => NetworkSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NetworkSettings.fromJson(Map<String, dynamic> json) => NetworkSettings(
    bridge: json["Bridge"],
    sandboxId: json["SandboxID"],
    sandboxKey: json["SandboxKey"],
    ports: json["Ports"] == null ? null : Port.fromJson(json["Ports"]),
    hairpinMode: json["HairpinMode"],
    linkLocalIPv6Address: json["LinkLocalIPv6Address"],
    linkLocalIPv6PrefixLen: json["LinkLocalIPv6PrefixLen"],
    secondaryIpAddresses: json["SecondaryIPAddresses"],
    secondaryIPv6Addresses: json["SecondaryIPv6Addresses"],
    endpointId: json["EndpointID"],
    gateway: json["Gateway"],
    globalIPv6Address: json["GlobalIPv6Address"],
    globalIPv6PrefixLen: json["GlobalIPv6PrefixLen"],
    ipAddress: json["IPAddress"],
    ipPrefixLen: json["IPPrefixLen"],
    iPv6Gateway: json["IPv6Gateway"],
    macAddress: json["MacAddress"],
    networks: json["Networks"] == null ? null : Networks.fromJson(json["Networks"]),
  );

  Map<String, dynamic> toJson() => {
    "Bridge": bridge,
    "SandboxID": sandboxId,
    "SandboxKey": sandboxKey,
    "Ports": ports?.toJson(),
    "HairpinMode": hairpinMode,
    "LinkLocalIPv6Address": linkLocalIPv6Address,
    "LinkLocalIPv6PrefixLen": linkLocalIPv6PrefixLen,
    "SecondaryIPAddresses": secondaryIpAddresses,
    "SecondaryIPv6Addresses": secondaryIPv6Addresses,
    "EndpointID": endpointId,
    "Gateway": gateway,
    "GlobalIPv6Address": globalIPv6Address,
    "GlobalIPv6PrefixLen": globalIPv6PrefixLen,
    "IPAddress": ipAddress,
    "IPPrefixLen": ipPrefixLen,
    "IPv6Gateway": iPv6Gateway,
    "MacAddress": macAddress,
    "Networks": networks?.toJson(),
  };
}

class Networks {
  Bridge? bridge;

  Networks({
    this.bridge,
  });

  factory Networks.fromRawJson(String str) => Networks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
    bridge: json["bridge"] == null ? null : Bridge.fromJson(json["bridge"]),
  );

  Map<String, dynamic> toJson() => {
    "bridge": bridge?.toJson(),
  };
}

class Bridge {
  dynamic ipamConfig;
  dynamic links;
  dynamic aliases;
  String? macAddress;
  dynamic driverOpts;
  int? gwPriority;
  String? networkId;
  String? endpointId;
  String? gateway;
  String? ipAddress;
  int? ipPrefixLen;
  String? iPv6Gateway;
  String? globalIPv6Address;
  int? globalIPv6PrefixLen;
  dynamic dnsNames;

  Bridge({
    this.ipamConfig,
    this.links,
    this.aliases,
    this.macAddress,
    this.driverOpts,
    this.gwPriority,
    this.networkId,
    this.endpointId,
    this.gateway,
    this.ipAddress,
    this.ipPrefixLen,
    this.iPv6Gateway,
    this.globalIPv6Address,
    this.globalIPv6PrefixLen,
    this.dnsNames,
  });

  factory Bridge.fromRawJson(String str) => Bridge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bridge.fromJson(Map<String, dynamic> json) => Bridge(
    ipamConfig: json["IPAMConfig"],
    links: json["Links"],
    aliases: json["Aliases"],
    macAddress: json["MacAddress"],
    driverOpts: json["DriverOpts"],
    gwPriority: json["GwPriority"],
    networkId: json["NetworkID"],
    endpointId: json["EndpointID"],
    gateway: json["Gateway"],
    ipAddress: json["IPAddress"],
    ipPrefixLen: json["IPPrefixLen"],
    iPv6Gateway: json["IPv6Gateway"],
    globalIPv6Address: json["GlobalIPv6Address"],
    globalIPv6PrefixLen: json["GlobalIPv6PrefixLen"],
    dnsNames: json["DNSNames"],
  );

  Map<String, dynamic> toJson() => {
    "IPAMConfig": ipamConfig,
    "Links": links,
    "Aliases": aliases,
    "MacAddress": macAddress,
    "DriverOpts": driverOpts,
    "GwPriority": gwPriority,
    "NetworkID": networkId,
    "EndpointID": endpointId,
    "Gateway": gateway,
    "IPAddress": ipAddress,
    "IPPrefixLen": ipPrefixLen,
    "IPv6Gateway": iPv6Gateway,
    "GlobalIPv6Address": globalIPv6Address,
    "GlobalIPv6PrefixLen": globalIPv6PrefixLen,
    "DNSNames": dnsNames,
  };
}

class State {
  String? status;
  bool? running;
  bool? paused;
  bool? restarting;
  bool? oomKilled;
  bool? dead;
  int? pid;
  int? exitCode;
  String? error;
  DateTime? startedAt;
  DateTime? finishedAt;

  State({
    this.status,
    this.running,
    this.paused,
    this.restarting,
    this.oomKilled,
    this.dead,
    this.pid,
    this.exitCode,
    this.error,
    this.startedAt,
    this.finishedAt,
  });

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
    status: json["Status"],
    running: json["Running"],
    paused: json["Paused"],
    restarting: json["Restarting"],
    oomKilled: json["OOMKilled"],
    dead: json["Dead"],
    pid: json["Pid"],
    exitCode: json["ExitCode"],
    error: json["Error"],
    startedAt: json["StartedAt"] == null ? null : DateTime.parse(json["StartedAt"]),
    finishedAt: json["FinishedAt"] == null ? null : DateTime.parse(json["FinishedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Running": running,
    "Paused": paused,
    "Restarting": restarting,
    "OOMKilled": oomKilled,
    "Dead": dead,
    "Pid": pid,
    "ExitCode": exitCode,
    "Error": error,
    "StartedAt": startedAt?.toIso8601String(),
    "FinishedAt": finishedAt?.toIso8601String(),
  };
}
