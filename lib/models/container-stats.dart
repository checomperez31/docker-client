import 'dart:convert';

class ContainerStats {
  String? name;
  String? id;
  DateTime? read;
  DateTime? preread;
  PidsStats? pidsStats;
  BlkioStats? blkioStats;
  int? numProcs;
  StorageStats? storageStats;
  CpuStats? cpuStats;
  PrecpuStats? precpuStats;
  MemoryStats? memoryStats;
  Networks? networks;

  ContainerStats({
    this.name,
    this.id,
    this.read,
    this.preread,
    this.pidsStats,
    this.blkioStats,
    this.numProcs,
    this.storageStats,
    this.cpuStats,
    this.precpuStats,
    this.memoryStats,
    this.networks,
  });

  factory ContainerStats.fromRawJson(String str) => ContainerStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContainerStats.fromJson(Map<String, dynamic> json) => ContainerStats(
    name: json["name"],
    id: json["id"],
    read: json["read"] == null ? null : DateTime.parse(json["read"]),
    preread: json["preread"] == null ? null : DateTime.parse(json["preread"]),
    pidsStats: json["pids_stats"] == null ? null : PidsStats.fromJson(json["pids_stats"]),
    blkioStats: json["blkio_stats"] == null ? null : BlkioStats.fromJson(json["blkio_stats"]),
    numProcs: json["num_procs"],
    storageStats: json["storage_stats"] == null ? null : StorageStats.fromJson(json["storage_stats"]),
    cpuStats: json["cpu_stats"] == null ? null : CpuStats.fromJson(json["cpu_stats"]),
    precpuStats: json["precpu_stats"] == null ? null : PrecpuStats.fromJson(json["precpu_stats"]),
    memoryStats: json["memory_stats"] == null ? null : MemoryStats.fromJson(json["memory_stats"]),
    networks: json["networks"] == null ? null : Networks.fromJson(json["networks"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "read": read?.toIso8601String(),
    "preread": preread?.toIso8601String(),
    "pids_stats": pidsStats?.toJson(),
    "blkio_stats": blkioStats?.toJson(),
    "num_procs": numProcs,
    "storage_stats": storageStats?.toJson(),
    "cpu_stats": cpuStats?.toJson(),
    "precpu_stats": precpuStats?.toJson(),
    "memory_stats": memoryStats?.toJson(),
    "networks": networks?.toJson(),
  };

  String getCpuUsage() {
    double cores = (numProcs?.toDouble() ?? 0.0);
    if (cores == 0) cores = (precpuStats?.onlineCpus ?? 1);
    return ((cpuStats?.getContainerCpuUsage() ?? 0) * (cores)).toStringAsFixed(3);
  }

  String getMemory() {
    return (memoryStats?.usage ?? 0).toString();
  }
}

class BlkioStats {
  List<IoServiceBytesRecursive>? ioServiceBytesRecursive;
  dynamic ioServicedRecursive;
  dynamic ioQueueRecursive;
  dynamic ioServiceTimeRecursive;
  dynamic ioWaitTimeRecursive;
  dynamic ioMergedRecursive;
  dynamic ioTimeRecursive;
  dynamic sectorsRecursive;

  BlkioStats({
    this.ioServiceBytesRecursive,
    this.ioServicedRecursive,
    this.ioQueueRecursive,
    this.ioServiceTimeRecursive,
    this.ioWaitTimeRecursive,
    this.ioMergedRecursive,
    this.ioTimeRecursive,
    this.sectorsRecursive,
  });

  factory BlkioStats.fromRawJson(String str) => BlkioStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlkioStats.fromJson(Map<String, dynamic> json) => BlkioStats(
    ioServiceBytesRecursive: json["io_service_bytes_recursive"] == null ? [] : List<IoServiceBytesRecursive>.from(json["io_service_bytes_recursive"]!.map((x) => IoServiceBytesRecursive.fromJson(x))),
    ioServicedRecursive: json["io_serviced_recursive"],
    ioQueueRecursive: json["io_queue_recursive"],
    ioServiceTimeRecursive: json["io_service_time_recursive"],
    ioWaitTimeRecursive: json["io_wait_time_recursive"],
    ioMergedRecursive: json["io_merged_recursive"],
    ioTimeRecursive: json["io_time_recursive"],
    sectorsRecursive: json["sectors_recursive"],
  );

  Map<String, dynamic> toJson() => {
    "io_service_bytes_recursive": ioServiceBytesRecursive == null ? [] : List<dynamic>.from(ioServiceBytesRecursive!.map((x) => x.toJson())),
    "io_serviced_recursive": ioServicedRecursive,
    "io_queue_recursive": ioQueueRecursive,
    "io_service_time_recursive": ioServiceTimeRecursive,
    "io_wait_time_recursive": ioWaitTimeRecursive,
    "io_merged_recursive": ioMergedRecursive,
    "io_time_recursive": ioTimeRecursive,
    "sectors_recursive": sectorsRecursive,
  };
}

class IoServiceBytesRecursive {
  int? major;
  int? minor;
  String? op;
  int? value;

  IoServiceBytesRecursive({
    this.major,
    this.minor,
    this.op,
    this.value,
  });

  factory IoServiceBytesRecursive.fromRawJson(String str) => IoServiceBytesRecursive.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IoServiceBytesRecursive.fromJson(Map<String, dynamic> json) => IoServiceBytesRecursive(
    major: json["major"],
    minor: json["minor"],
    op: json["op"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "major": major,
    "minor": minor,
    "op": op,
    "value": value,
  };
}

class CpuStats {
  CpuUsage? cpuUsage;
  double? systemCpuUsage;
  int? onlineCpus;
  ThrottlingData? throttlingData;

  CpuStats({
    this.cpuUsage,
    this.systemCpuUsage,
    this.onlineCpus,
    this.throttlingData,
  });

  factory CpuStats.fromRawJson(String str) => CpuStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CpuStats.fromJson(Map<String, dynamic> json) => CpuStats(
    cpuUsage: json["cpu_usage"] == null ? null : CpuUsage.fromJson(json["cpu_usage"]),
    systemCpuUsage: json["system_cpu_usage"]?.toDouble(),
    onlineCpus: json["online_cpus"],
    throttlingData: json["throttling_data"] == null ? null : ThrottlingData.fromJson(json["throttling_data"]),
  );

  Map<String, dynamic> toJson() => {
    "cpu_usage": cpuUsage?.toJson(),
    "system_cpu_usage": systemCpuUsage,
    "online_cpus": onlineCpus,
    "throttling_data": throttlingData?.toJson(),
  };

  double getContainerCpuUsage() {
    return (cpuUsage?.totalUsage ?? 1) / (systemCpuUsage ?? 0) * 100;
  }
}

class CpuUsage {
  int? totalUsage;
  int? usageInKernelmode;
  int? usageInUsermode;

  CpuUsage({
    this.totalUsage,
    this.usageInKernelmode,
    this.usageInUsermode,
  });

  factory CpuUsage.fromRawJson(String str) => CpuUsage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CpuUsage.fromJson(Map<String, dynamic> json) => CpuUsage(
    totalUsage: json["total_usage"],
    usageInKernelmode: json["usage_in_kernelmode"],
    usageInUsermode: json["usage_in_usermode"],
  );

  Map<String, dynamic> toJson() => {
    "total_usage": totalUsage,
    "usage_in_kernelmode": usageInKernelmode,
    "usage_in_usermode": usageInUsermode,
  };
}

class ThrottlingData {
  int? periods;
  int? throttledPeriods;
  int? throttledTime;

  ThrottlingData({
    this.periods,
    this.throttledPeriods,
    this.throttledTime,
  });

  factory ThrottlingData.fromRawJson(String str) => ThrottlingData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThrottlingData.fromJson(Map<String, dynamic> json) => ThrottlingData(
    periods: json["periods"],
    throttledPeriods: json["throttled_periods"],
    throttledTime: json["throttled_time"],
  );

  Map<String, dynamic> toJson() => {
    "periods": periods,
    "throttled_periods": throttledPeriods,
    "throttled_time": throttledTime,
  };
}

class MemoryStats {
  int? usage;
  Map<String, int>? stats;
  int? limit;

  MemoryStats({
    this.usage,
    this.stats,
    this.limit,
  });

  factory MemoryStats.fromRawJson(String str) => MemoryStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemoryStats.fromJson(Map<String, dynamic> json) => MemoryStats(
    usage: json["usage"],
    stats: Map.from(json["stats"]!).map((k, v) => MapEntry<String, int>(k, v)),
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "usage": usage,
    "stats": Map.from(stats!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "limit": limit,
  };
}

class Networks {
  Eth0? eth0;

  Networks({
    this.eth0,
  });

  factory Networks.fromRawJson(String str) => Networks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
    eth0: json["eth0"] == null ? null : Eth0.fromJson(json["eth0"]),
  );

  Map<String, dynamic> toJson() => {
    "eth0": eth0?.toJson(),
  };
}

class Eth0 {
  int? rxBytes;
  int? rxPackets;
  int? rxErrors;
  int? rxDropped;
  int? txBytes;
  int? txPackets;
  int? txErrors;
  int? txDropped;

  Eth0({
    this.rxBytes,
    this.rxPackets,
    this.rxErrors,
    this.rxDropped,
    this.txBytes,
    this.txPackets,
    this.txErrors,
    this.txDropped,
  });

  factory Eth0.fromRawJson(String str) => Eth0.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Eth0.fromJson(Map<String, dynamic> json) => Eth0(
    rxBytes: json["rx_bytes"],
    rxPackets: json["rx_packets"],
    rxErrors: json["rx_errors"],
    rxDropped: json["rx_dropped"],
    txBytes: json["tx_bytes"],
    txPackets: json["tx_packets"],
    txErrors: json["tx_errors"],
    txDropped: json["tx_dropped"],
  );

  Map<String, dynamic> toJson() => {
    "rx_bytes": rxBytes,
    "rx_packets": rxPackets,
    "rx_errors": rxErrors,
    "rx_dropped": rxDropped,
    "tx_bytes": txBytes,
    "tx_packets": txPackets,
    "tx_errors": txErrors,
    "tx_dropped": txDropped,
  };
}

class PidsStats {
  int? current;
  int? limit;

  PidsStats({
    this.current,
    this.limit,
  });

  factory PidsStats.fromRawJson(String str) => PidsStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PidsStats.fromJson(Map<String, dynamic> json) => PidsStats(
    current: json["current"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "limit": limit,
  };
}

class PrecpuStats {
  CpuUsage? cpuUsage;
  ThrottlingData? throttlingData;
  double? systemCpuUsage;
  double? onlineCpus;

  PrecpuStats({
    this.cpuUsage,
    this.throttlingData,
    this.systemCpuUsage,
    this.onlineCpus
  });

  factory PrecpuStats.fromRawJson(String str) => PrecpuStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrecpuStats.fromJson(Map<String, dynamic> json) => PrecpuStats(
    cpuUsage: json["cpu_usage"] == null ? null : CpuUsage.fromJson(json["cpu_usage"]),
    throttlingData: json["throttling_data"] == null ? null : ThrottlingData.fromJson(json["throttling_data"]),
    systemCpuUsage: json["system_cpu_usage"] == null ? null : double.parse(json["system_cpu_usage"].toString()),
    onlineCpus: json["online_cpus"] == null ? null : double.parse(json["online_cpus"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "cpu_usage": cpuUsage?.toJson(),
    "throttling_data": throttlingData?.toJson(),
  };
}

class StorageStats {
  StorageStats();

  factory StorageStats.fromRawJson(String str) => StorageStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StorageStats.fromJson(Map<String, dynamic> json) => StorageStats(
  );

  Map<String, dynamic> toJson() => {
  };
}
