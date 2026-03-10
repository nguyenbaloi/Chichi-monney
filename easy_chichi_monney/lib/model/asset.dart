class Asset {
  final int? id;
  final String name;
  final String type;
  final int currentValue;
  final double currentPercent;
  final double targetPercent;
  final double diffPercent;

  Asset({
    this.id,
    required this.name,
    required this.type,
    required this.currentValue,
    required this.currentPercent,
    required this.targetPercent,
    required this.diffPercent,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    currentValue: json['current_value'],
    currentPercent: json['current_percent'],
    targetPercent: json['target_percent'],
    diffPercent: json['diff_percent'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'current_value': currentValue,
    'current_percent': currentPercent,
    'target_percent': targetPercent,
    'diff_percent': diffPercent,
  };
}
