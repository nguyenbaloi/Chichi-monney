import 'package:flutter/material.dart';
import 'package:easy_chichi_monney/model/asset.dart';
import 'package:easy_chichi_monney/screen/database_helper.dart';

class AssetFormPage extends StatefulWidget {
  final Asset? asset; // null = thêm mới

  const AssetFormPage({super.key, this.asset});

  @override
  State<AssetFormPage> createState() => _AssetFormPageState();
}

class _AssetFormPageState extends State<AssetFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final currentValueCtrl = TextEditingController();
  final currentPercentCtrl = TextEditingController();
  final targetPercentCtrl = TextEditingController();
  final diffPercentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Nếu sửa → đổ dữ liệu vào form
    if (widget.asset != null) {
      nameCtrl.text = widget.asset!.name;
      typeCtrl.text = widget.asset!.type;
      currentValueCtrl.text = widget.asset!.currentValue.toString();
      currentPercentCtrl.text = widget.asset!.currentPercent.toString();
      targetPercentCtrl.text = widget.asset!.targetPercent.toString();
      diffPercentCtrl.text = widget.asset!.diffPercent.toString();
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    typeCtrl.dispose();
    currentValueCtrl.dispose();
    currentPercentCtrl.dispose();
    targetPercentCtrl.dispose();
    diffPercentCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveAsset() async {
    if (!_formKey.currentState!.validate()) return;

    final asset = Asset(
      id: widget.asset?.id,
      name: nameCtrl.text,
      type: typeCtrl.text,
      currentValue: int.parse(currentValueCtrl.text),
      currentPercent: double.parse(currentPercentCtrl.text),
      targetPercent: double.parse(targetPercentCtrl.text),
      diffPercent: double.parse(diffPercentCtrl.text),
    );

    if (widget.asset == null) {
      await DatabaseHelper.instance.insertAsset(asset);
    } else {
      await DatabaseHelper.instance.updateAsset(asset);
    }

    Navigator.pop(context, true); // trả về true để refresh list
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.asset != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Sửa Asset" : "Thêm Asset"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Tên Asset"),
                validator: (v) => v!.isEmpty ? "Không được để trống" : null,
              ),
              TextFormField(
                controller: typeCtrl,
                decoration: const InputDecoration(labelText: "Loại"),
              ),
              TextFormField(
                controller: currentValueCtrl,
                decoration: const InputDecoration(labelText: "Giá trị hiện tại"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Không được để trống" : null,
              ),
              TextFormField(
                controller: currentPercentCtrl,
                decoration: const InputDecoration(labelText: "Tỷ lệ hiện tại (%)"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: targetPercentCtrl,
                decoration: const InputDecoration(labelText: "Tỷ lệ mục tiêu (%)"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: diffPercentCtrl,
                decoration: const InputDecoration(labelText: "Chênh lệch (%)"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveAsset,
                child: Text(isEdit ? "Lưu thay đổi" : "Thêm mới"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// Navigator.push(
// context,
// MaterialPageRoute(builder: (_) => const AssetFormPage()),
// ).then((refresh) {
// if (refresh == true) loadAssets();
// });
// ✏️ Sửa:
// Navigator.push(
// context,
// MaterialPageRoute(builder: (_) => AssetFormPage(asset: asset)),
// ).then((refresh) {
// if (refresh == true) loadAssets();
// });