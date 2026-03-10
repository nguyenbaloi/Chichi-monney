import 'package:flutter/material.dart';
import 'package:easy_chichi_monney/model/history.dart';
import 'package:easy_chichi_monney/screen/database_helper.dart';

class HistoryFormPage extends StatefulWidget {
  final History? history; // null = thêm mới

  const HistoryFormPage({super.key, this.history});

  @override
  State<HistoryFormPage> createState() => _HistoryFormPageState();
}

class _HistoryFormPageState extends State<HistoryFormPage> {
  final _formKey = GlobalKey<FormState>();

  final totalDepositCtrl = TextEditingController();
  final depositWithdrawCtrl = TextEditingController();
  final currentAssetCtrl = TextEditingController();
  final resultCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Nếu sửa → gán giá trị
    if (widget.history != null) {
      totalDepositCtrl.text = widget.history!.totalInvest.toString();
      depositWithdrawCtrl.text = widget.history!.depositWithdraw.toString();
      currentAssetCtrl.text = widget.history!.currentAsset.toString();
      resultCtrl.text = widget.history!.ketqua.toString();
      dateCtrl.text = widget.history!.date;
      noteCtrl.text = widget.history!.note;
    }
  }

  @override
  void dispose() {
    totalDepositCtrl.dispose();
    depositWithdrawCtrl.dispose();
    currentAssetCtrl.dispose();
    resultCtrl.dispose();
    dateCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveHistory() async {
    if (!_formKey.currentState!.validate()) return;

    final history = History(
      id: widget.history!.id,
      totalInvest: int.parse(totalDepositCtrl.text),
      depositWithdraw: int.parse(depositWithdrawCtrl.text),
      currentAsset: int.parse(currentAssetCtrl.text),
      ketqua: int.parse(resultCtrl.text),
      date: dateCtrl.text,
      note: noteCtrl.text,
    );

    if (widget.history == null) {
      await DatabaseHelper.instance.insertHistory(history);
    } else {
      await DatabaseHelper.instance.updateHistory(history);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.history != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Sửa lịch sử" : "Thêm lịch sử"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: totalDepositCtrl,
                decoration: const InputDecoration(labelText: "Tổng nạp"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Không được để trống" : null,
              ),

              TextFormField(
                controller: depositWithdrawCtrl,
                decoration: const InputDecoration(labelText: "Nạp / Rút"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: currentAssetCtrl,
                decoration: const InputDecoration(labelText: "Giá trị tài sản"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: resultCtrl,
                decoration: const InputDecoration(labelText: "Kết quả lời/lỗ"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: dateCtrl,
                decoration: const InputDecoration(labelText: "Ngày (dd/mm/yyyy)"),
                validator: (v) => v!.isEmpty ? "Không được để trống" : null,
              ),

              TextFormField(
                controller: noteCtrl,
                decoration: const InputDecoration(labelText: "Ghi chú"),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveHistory,
                child: Text(isEdit ? "Lưu thay đổi" : "Thêm mới"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// Navigator.push(
// context,
// MaterialPageRoute(builder: (_) => const HistoryFormPage()),
// ).then((refresh) {
// if (refresh == true) loadHistory();
// });
// ✏️ Sửa
// Navigator.push(
// context,
// MaterialPageRoute(builder: (_) => HistoryFormPage(history: item)),
// ).then((refresh) {
// if (refresh == true) loadHistory();
// });
