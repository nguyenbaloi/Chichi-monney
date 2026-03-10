import 'package:flutter/material.dart';
import '../btc/btc_page.dart';
import '../dashboard/dashboard.dart';
import '../history/history.dart';
import '../my_asset/my_asset.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Easy Chichi Money"),
        backgroundColor: Colors.amber,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.yellow,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: "Assets",),
            Tab(icon: Icon(Icons.currency_bitcoin), text: "BTC"),
            Tab(icon: Icon(Icons.history), text: "History"),
            Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
          ],
        ),
      ),

      body: TabBarView(
        controller: tabController,
        children: const [
          AssetListPage(),      // Danh sách asset
          BTCPage(),            // Danh sách BTC (lọc type = 2 hoặc 3 tuỳ bạn)
          HistoryListPage(),    // Lịch sử nạp/rút/tài sản
          DashboardPage(),      // Dashboard tổng quan
        ],
      ),
    );
  }
}
