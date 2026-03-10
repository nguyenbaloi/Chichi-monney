import 'package:flutter/material.dart';
import '../../model/asset.dart';
import '../database_helper.dart';

class BTCPage extends StatefulWidget {
  const BTCPage({super.key});

  @override
  State<BTCPage> createState() => _BTCPageState();
}

class _BTCPageState extends State<BTCPage> {
  List<Asset> btcAssets = [];

  @override
  void initState() {
    super.initState();
    loadBTC();
  }

  Future<void> loadBTC() async {
    final all = await DatabaseHelper.instance.getAssets();

    // lọc các tài sản crypto/btc
    btcAssets = all.where((a) => a.type == 2 || a.type == 3).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return btcAssets.isEmpty
        ? const Center(child: Text("Không có tài sản BTC/Crypto"))
        : ListView.builder(
      itemCount: btcAssets.length,
      itemBuilder: (_, i) {
        final a = btcAssets[i];
        return Card(
          child: ListTile(
            title: Text(a.name),
            subtitle: Text("Giá trị hiện tại: ${a.currentValue}"),
          ),
        );
      },
    );
  }
}
