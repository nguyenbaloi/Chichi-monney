// // File: edit_pie_data_screen.dart
// import 'package:flutter/material.dart';
// import 'package:easy_chichi_monney/screen/home/home_chart.dart';
//
// class EditPieDataScreen extends StatefulWidget {
//   final PieData item;
//   final int index;
//
//   const EditPieDataScreen({
//     super.key,
//     required this.item,
//     required this.index,
//   });
//
//   @override
//   State<EditPieDataScreen> createState() => _EditPieDataScreenState();
// }
//
// class _EditPieDataScreenState extends State<EditPieDataScreen> {
//   late TextEditingController _titleController;
//   late TextEditingController _valueController;
//   late TextEditingController _descController;
//   late Color selectedColor;
//
//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.item.title);
//     _valueController = TextEditingController(text: widget.item.value.toString());
//     _descController = TextEditingController(text: widget.item.description ?? '');
//     selectedColor = widget.item.color;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sửa dữ liệu")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: "Tên mục"),
//             ),
//             TextField(
//               controller: _valueController,
//               decoration: const InputDecoration(labelText: "Giá trị"),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _descController,
//               decoration: const InputDecoration(labelText: "Mô tả"),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const Text("Màu: "),
//                 Wrap(
//                   spacing: 8,
//                   children: [
//                     Colors.blue,
//                     Colors.red,
//                     Colors.green,
//                     Colors.orange,
//                     Colors.purple,
//                     Colors.teal,
//                   ].map((c) {
//                     return GestureDetector(
//                       onTap: () => setState(() => selectedColor = c),
//                       child: Container(
//                         width: 28,
//                         height: 28,
//                         decoration: BoxDecoration(
//                           color: c,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: selectedColor == c
//                                 ? Colors.black
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 final updated = PieData(
//                   _titleController.text,
//                   double.tryParse(_valueController.text) ?? 0,
//                   selectedColor,
//                   _descController.text,
//                 );
//                 Navigator.pop(context, updated);
//               },
//               child: const Text("Lưu thay đổi"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
