import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../model/asset.dart';
import '../../model/history.dart';
import '../database_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Asset> assets = [];
  List<History> history = [];

  double totalAsset = 0;
  double totalDeposit = 0;
  double totalResult = 0;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    assets = await DatabaseHelper.instance.getAssets();
    history = await DatabaseHelper.instance.getHistory();

    if (history.isNotEmpty) {
      final last = history.last;

      totalAsset = last.currentAsset.toDouble();        // Tổng tài sản hiện tại
      totalDeposit = last.totalInvest.toDouble();       // Tổng nạp (total_invest)
      totalResult = last.ketqua.toDouble();             // Lời/lỗ (ketqua)
    }

    setState(() {});
  }

  List<PieChartSectionData> _buildPieData() {
    if (totalAsset == 0) return [];

    return assets.map((a) {
      return PieChartSectionData(
        value: a.currentValue.toDouble(),
        title: a.name,
        radius: 65,
      );
    }).toList();
  }

  Widget _infoCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard tổng quan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: assets.isEmpty
            ? const Center(child: Text("Chưa có dữ liệu tài sản"))
            : SingleChildScrollView(
          child: Column(
            children: [
              // Cards tổng số liệu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _infoCard(
                      "Tổng tài sản",
                      totalAsset.toStringAsFixed(0),
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _infoCard(
                      "Tổng Deposit",
                      totalDeposit.toStringAsFixed(0),
                      Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _infoCard(
                "Lời / Lỗ",
                totalResult.toStringAsFixed(0),
                totalResult >= 0 ? Colors.green : Colors.red,
              ),

              const SizedBox(height: 20),

              // Biểu đồ Pie Chart
              const Text(
                "Phân bổ tài sản",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 260,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieData(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Chi tiết tài sản:",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              ...assets.map(
                    (a) => Card(
                  child: ListTile(
                    title: Text("${a.name} (${a.type})"),
                    subtitle: Text(
                        "Giá trị: ${a.currentValue}, Tỷ lệ: ${a.currentPercent}%"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
