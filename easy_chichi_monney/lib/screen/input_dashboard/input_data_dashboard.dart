// // File: pie_chart_editor.dart
// import 'package:flutter/material.dart';
// import 'package:easy_chichi_monney/screen/home/home_chart.dart';
//
// class PieChartEditorScreen extends StatefulWidget {
//   const PieChartEditorScreen({super.key});
//
//   @override
//   State<PieChartEditorScreen> createState() => _PieChartEditorScreenState();
// }
//
// class _PieChartEditorScreenState extends State<PieChartEditorScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _valueController = TextEditingController();
//   final _descController = TextEditingController();
//
//   List<PieData> data = [
//     PieData('Ăn uống', 45, Colors.blue, 'Chi tiêu ăn uống'),
//     PieData('Đi lại', 25, Colors.red, 'Chi phí đi lại'),
//   ];
//
//   Color selectedColor = Colors.blue;
//
//   void _addData() {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         data.add(
//           PieData(
//             _titleController.text,
//             double.parse(_valueController.text),
//             selectedColor,
//             _descController.text,
//           ),
//         );
//         _resetForm();
//       });
//     }
//   }
//
//   void _resetForm() {
//     _titleController.clear();
//     _valueController.clear();
//     _descController.clear();
//     selectedColor = Colors.blue;
//   }
//
//   void _editData(int index) {
//     final item = data[index];
//     _titleController.text = item.title;
//     _valueController.text = item.value.toString();
//     _descController.text = item.description ?? '';
//     selectedColor = item.color;
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Sửa dữ liệu"),
//         content: StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(labelText: "Tên mục"),
//                   ),
//                   TextField(
//                     controller: _valueController,
//                     decoration: const InputDecoration(labelText: "Giá trị"),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextField(
//                     controller: _descController,
//                     decoration: const InputDecoration(labelText: "Mô tả"),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       const Text("Màu: "),
//                       Wrap(
//                         spacing: 8,
//                         children: [
//                           Colors.blue,
//                           Colors.red,
//                           Colors.green,
//                           Colors.orange,
//                           Colors.purple,
//                           Colors.teal,
//                         ].map((c) {
//                           return GestureDetector(
//                             onTap: () => setStateDialog(() {
//                               selectedColor = c;
//                             }),
//                             child: Container(
//                               width: 28,
//                               height: 28,
//                               decoration: BoxDecoration(
//                                 color: c,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: selectedColor == c
//                                       ? Colors.black
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 data.removeAt(index);
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Xóa", style: TextStyle(color: Colors.red)),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 data[index] = PieData(
//                   _titleController.text,
//                   double.tryParse(_valueController.text) ?? 0,
//                   selectedColor,
//                   _descController.text,
//                 );
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Lưu"),
//           ),
//         ],
//       ),
//     ).then((_) => _resetForm());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Biểu đồ động")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// Form thêm mới
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(labelText: "Tên mục"),
//                     validator: (v) => v == null || v.isEmpty ? "Nhập tên" : null,
//                   ),
//                   TextFormField(
//                     controller: _valueController,
//                     decoration: const InputDecoration(labelText: "Giá trị"),
//                     keyboardType: TextInputType.number,
//                     validator: (v) {
//                       if (v == null || v.isEmpty) return "Nhập giá trị";
//                       final num? val = num.tryParse(v);
//                       if (val == null) return "Phải là số";
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _descController,
//                     decoration: const InputDecoration(labelText: "Mô tả"),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       const Text("Màu: "),
//                       Wrap(
//                         spacing: 8,
//                         children: [
//                           Colors.blue,
//                           Colors.red,
//                           Colors.green,
//                           Colors.orange,
//                           Colors.purple,
//                           Colors.teal,
//                         ].map((c) {
//                           return GestureDetector(
//                             onTap: () => setState(() {
//                               selectedColor = c;
//                             }),
//                             child: Container(
//                               width: 28,
//                               height: 28,
//                               decoration: BoxDecoration(
//                                 color: c,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: selectedColor == c
//                                       ? Colors.black
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _addData,
//                     child: const Text("Thêm dữ liệu"),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /// Biểu đồ với khả năng click vào legend để sửa
//             PieChartWithDescription(
//               title: "Thống kê chi phí",
//               data: data,
//             ),
//
//             const SizedBox(height: 16),
//             /// Hiển thị danh sách LegendItem để sửa / xóa
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: List.generate(data.length, (i) {
//                 final d = data[i];
//                 return GestureDetector(
//                   onTap: () => _editData(i),
//                   child: Chip(
//                     avatar: CircleAvatar(backgroundColor: d.color),
//                     label: Text(d.title),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
