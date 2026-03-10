import 'package:flutter/material.dart';
import 'package:easy_chichi_monney/screen/database_helper.dart';
import '../../model/history.dart';
import '../edit_asset_his/edit_history.dart';

class HistoryListPage extends StatefulWidget {
  const HistoryListPage({super.key});

  @override
  State<HistoryListPage> createState() => _HistoryListPageState();
}

class _HistoryListPageState extends State<HistoryListPage> {
  List<History> historyList = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    historyList = await DatabaseHelper.instance.getHistory();
    setState(() {});
  }

  Future<void> _deleteHistory(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Xóa mục này?"),
        content: const Text("Bạn có chắc muốn xóa mục này không?"),
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
      await DatabaseHelper.instance.deleteHistory(id);
      loadHistory();
    }
  }

  void _openForm({History? item}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HistoryFormPage(history: item)),
    ).then((refresh) {
      if (refresh == true) loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử biến động tài sản"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: historyList.isEmpty
          ? const Center(child: Text("Chưa có dữ liệu"))
          : ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final h = historyList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("Ngày: ${h.date}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tổng nạp: ${h.totalInvest}"),
                  Text("Nạp/Rút: ${h.depositWithdraw}"),
                  Text("Giá trị tài sản: ${h.currentAsset}"),
                  Text("Kết quả: ${h.ketqua}"),
                  if (h.note.isNotEmpty) Text("Ghi chú: ${h.note}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _openForm(item: h),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteHistory(h.id!),
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
