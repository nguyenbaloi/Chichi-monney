class History {
  final int? id;
  final int totalInvest;
  final int depositWithdraw;
  final int currentAsset;
  final int ketqua;
  final String date;
  final String note;

  History({
    this.id,
    required this.totalInvest,
    required this.depositWithdraw,
    required this.currentAsset,
    required this.ketqua,
    required this.date,
    required this.note,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json['id'],
    totalInvest: json['total_invest'],          // ✔ đúng theo DB
    depositWithdraw: json['deposit_withdraw'],  // ✔ đúng theo DB
    currentAsset: json['current_asset'],        // ✔ đúng theo DB
    ketqua: json['ketqua'],                     // ✔ đúng theo DB
    date: json['date'],
    note: json['note'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'total_invest': totalInvest,                // ✔ đúng theo DB
    'deposit_withdraw': depositWithdraw,        // ✔ đúng theo DB
    'current_asset': currentAsset,              // ✔ đúng theo DB
    'ketqua': ketqua,                           // ✔ đúng theo DB
    'date': date,
    'note': note,
  };
}
