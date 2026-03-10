import 'package:flutter/material.dart';
import '../../model/asset.dart';
import '../database_helper.dart';
import '../edit_asset_his/edit_asset.dart';

class AssetListPage extends StatefulWidget {
  const AssetListPage({super.key});

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  List<Asset> assetList = [];

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  Future<void> loadAssets() async {
    assetList = await DatabaseHelper.instance.getAssets();
    setState(() {});
  }

  Future<void> _deleteAsset(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Xóa Asset?"),
        content: const Text("Bạn có chắc muốn xóa tài sản này không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteAsset(id);
      loadAssets();
    }
  }

  void _openForm({Asset? asset}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AssetFormPage(asset: asset)),
    ).then((refresh) {
      if (refresh == true) loadAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách tài sản"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: assetList.isEmpty
          ? const Center(child: Text("Chưa có dữ liệu"))
          : ListView.builder(
        itemCount: assetList.length,
        itemBuilder: (context, index) {
          final a = assetList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("${a.name} (${a.type})",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Giá trị hiện tại: ${a.currentValue}"),
                  Text("Tỷ lệ hiện tại: ${a.currentPercent}%"),
                  Text("Tỷ lệ mục tiêu: ${a.targetPercent}%"),
                  Text("Chênh lệch: ${a.diffPercent}%"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _openForm(asset: a),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAsset(a.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
