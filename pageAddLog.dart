// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'pick_picture.dart';  // นำเข้าไฟล์ใหม่
// import '../database/db_manage.dart';
//
// class AddTransaction extends StatefulWidget {
//   @override
//   _AddTransactionState createState() => _AddTransactionState();
// }
//
// class _AddTransactionState extends State<AddTransaction> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _memoController = TextEditingController();
//   final ImageOcrHelper _imageOcrHelper = ImageOcrHelper();  // สร้างอินสแตนซ์ของ ImageOcrHelper
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _memoController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImageAndExtractText() async {
//     final extractedText = await _imageOcrHelper.pickImageAndExtractText();
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense & Income Log'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             children: [
//               FormBuilderDropdown<String>(
//                 name: 'transactionType',
//                 decoration: InputDecoration(
//                   labelText: 'Select Transaction Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Income', 'Expense']
//                     .map((type) => DropdownMenuItem(
//                   value: type == 'Income' ? '1' : '0',
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDateTimePicker(
//                 name: 'date',
//                 inputType: InputType.date,
//                 decoration: InputDecoration(
//                   labelText: 'Select Date',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDropdown<String>(
//                 name: 'category',
//                 decoration: InputDecoration(
//                   labelText: 'Select Category',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Food', 'Car fare', 'Gasoline cost', 'Cost of equipment', 'Other']
//                     .map((category) => DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: FormBuilderTextField(
//                       name: 'amount',
//                       controller: _amountController,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Amount of Money',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.numeric(),
//                       ]),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.photo),
//                     onPressed: _pickImageAndExtractText,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               FormBuilderTextField(
//                 name: 'memo',
//                 controller: _memoController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Memo',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     var typeExpense = _formKey.currentState?.value['transactionType'];
//                     var date = _formKey.currentState?.value['date'];
//                     var category = _formKey.currentState?.value['category'];
//                     var amount = _amountController.text;
//                     var memo = _memoController.text;
//
//                     // Get category ID
//                     int? typeTransactionId = await DatabaseManagement.instance.getTypeTransactionId(
//                       category,
//                     );
//
//                     if (typeTransactionId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Invalid category selected.'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     Map<String, dynamic> row = {
//                       'date_user': date.toString(),
//                       'amount_transaction': double.parse(amount),
//                       'type_expense': typeExpense == '1' ? 1 : 0,
//                       'memo_transaction': memo,
//                       'ID_type_transaction': typeTransactionId,
//                     };
//
//                     await DatabaseManagement.instance.insertTransaction(row);
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//**********************************************
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'pick_picture.dart';  // นำเข้าไฟล์ใหม่
// import '../database/db_manage.dart';
// import 'package:flutter/services.dart'; // นำเข้า
//
// class AddTransaction extends StatefulWidget {
//   @override
//   _AddTransactionState createState() => _AddTransactionState();
// }
//
// class _AddTransactionState extends State<AddTransaction> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _memoController = TextEditingController();
//   final ImageOcrHelper _imageOcrHelper = ImageOcrHelper();  // สร้างอินสแตนซ์ของ ImageOcrHelper
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _memoController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImageAndExtractText() async {
//     final extractedText = await _imageOcrHelper.pickImageAndExtractText();
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText;
//       });
//     }
//   }
//
//   Future<void> _handleIncomingImage(String imageUri) async {
//     final extractedText = await _imageOcrHelper.extractTextFromImage(imageUri);
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText; // กำหนดค่าที่กรอกเงิน
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // เพิ่มการตั้งค่าที่นี่เพื่อรับข้อมูลจากการแชร์
//     const MethodChannel channel = MethodChannel('vongola');
//     channel.setMethodCallHandler((call) async {
//       if (call.method == 'shareImage') {
//         final String imageUri = call.arguments;
//         await _handleIncomingImage(imageUri);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense & Income Log'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             children: [
//               FormBuilderDropdown<String>(
//                 name: 'transactionType',
//                 decoration: InputDecoration(
//                   labelText: 'Select Transaction Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Income', 'Expense']
//                     .map((type) => DropdownMenuItem(
//                   value: type == 'Income' ? '1' : '0',
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDateTimePicker(
//                 name: 'date',
//                 inputType: InputType.date,
//                 decoration: InputDecoration(
//                   labelText: 'Select Date',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDropdown<String>(
//                 name: 'category',
//                 decoration: InputDecoration(
//                   labelText: 'Select Category',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Food', 'Car fare', 'Gasoline cost', 'Cost of equipment', 'Other']
//                     .map((category) => DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: FormBuilderTextField(
//                       name: 'amount',
//                       controller: _amountController,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Amount of Money',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.numeric(),
//                       ]),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.photo),
//                     onPressed: _pickImageAndExtractText,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               FormBuilderTextField(
//                 name: 'memo',
//                 controller: _memoController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Memo',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     var typeExpense = _formKey.currentState?.value['transactionType'];
//                     var date = _formKey.currentState?.value['date'];
//                     var category = _formKey.currentState?.value['category'];
//                     var amount = _amountController.text;
//                     var memo = _memoController.text;
//
//                     // Get category ID
//                     int? typeTransactionId = await DatabaseManagement.instance.getTypeTransactionId(
//                       category,
//                     );
//
//                     if (typeTransactionId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Invalid category selected.'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     Map<String, dynamic> row = {
//                       'date_user': date.toString(),
//                       'amount_transaction': double.parse(amount),
//                       'type_expense': typeExpense == '1' ? 1 : 0,
//                       'memo_transaction': memo,
//                       'ID_type_transaction': typeTransactionId,
//                     };
//
//                     await DatabaseManagement.instance.insertTransaction(row);
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//ก่อนแก้11.16
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'pick_picture.dart';  // นำเข้าไฟล์ใหม่
// import '../database/db_manage.dart';
// import 'package:flutter/services.dart'; // นำเข้า
//
// class AddTransaction extends StatefulWidget {
//   final String? imageUri; // เพิ่มพารามิเตอร์นี้
//
//   AddTransaction({Key? key, this.imageUri}) : super(key: key);
//
//   @override
//   _AddTransactionState createState() => _AddTransactionState();
// }
// // class AddTransaction extends StatefulWidget {
// //   final String imageUri; // รับ imageUri
// //
// //   // constructor ที่รับ imageUri
// //   AddTransaction({required this.imageUri});
// //
// //   @override
// //   _AddTransactionState createState() => _AddTransactionState();
// // }
//
//
// class _AddTransactionState extends State<AddTransaction> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _memoController = TextEditingController();
//   final ImageOcrHelper _imageOcrHelper = ImageOcrHelper();  // สร้างอินสแตนซ์ของ ImageOcrHelper
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _memoController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImageAndExtractText() async {
//     final extractedText = await _imageOcrHelper.pickImageAndExtractText();
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText;
//       });
//     }
//   }
//
//   Future<void> _handleIncomingImage(String imageUri) async {
//     final extractedText = await _imageOcrHelper.extractTextFromImage(imageUri);
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText; // กำหนดค่าที่กรอกเงิน
//       });
//     }
//   }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // ตรวจสอบว่ามีค่า imageUri หรือไม่
//   //   if (widget.imageUri != null) {
//   //     _handleIncomingImage(widget.imageUri!);
//   //   }
//   //   // เพิ่มการตั้งค่าที่นี่เพื่อรับข้อมูลจากการแชร์
//   //   const MethodChannel channel = MethodChannel("vongola");
//   //   channel.setMethodCallHandler((call) async {
//   //     if (call.method == 'shareImage') {
//   //       final String imageUri = call.arguments;
//   //       await _handleIncomingImage(imageUri);
//   //     }
//   //   });
//   // }
//   @override
//   void initState() {
//     super.initState();
//
//     // ตรวจสอบว่ามีค่า imageUri หรือไม่
//     String? imageUri = widget.imageUri; // ใช้ค่าที่อาจจะเป็น null
//     if (imageUri != null && imageUri.isNotEmpty) { // ตรวจสอบว่า imageUri ไม่เป็น null และไม่ว่าง
//       _handleIncomingImage(imageUri); // เรียกใช้ฟังก์ชันที่จัดการกับภาพที่แชร์
//     }
//
//     // เพิ่มการตั้งค่าที่นี่เพื่อรับข้อมูลจากการแชร์
//     const MethodChannel channel = MethodChannel("vongola");
//     channel.setMethodCallHandler((call) async {
//       if (call.method == 'shareImage') {
//         final String imageUri = call.arguments;
//         await _handleIncomingImage(imageUri);
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense & Income Log'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             children: [
//               FormBuilderDropdown<String>(
//                 name: 'transactionType',
//                 decoration: InputDecoration(
//                   labelText: 'Select Transaction Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Income', 'Expense']
//                     .map((type) => DropdownMenuItem(
//                   value: type == 'Income' ? '1' : '0',
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDateTimePicker(
//                 name: 'date',
//                 inputType: InputType.date,
//                 decoration: InputDecoration(
//                   labelText: 'Select Date',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDropdown<String>(
//                 name: 'category',
//                 decoration: InputDecoration(
//                   labelText: 'Select Category',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Food', 'Car fare', 'Gasoline cost', 'Cost of equipment', 'Other']
//                     .map((category) => DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: FormBuilderTextField(
//                       name: 'amount',
//                       controller: _amountController,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Amount of Money',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.numeric(),
//                       ]),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.photo),
//                     onPressed: _pickImageAndExtractText,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               FormBuilderTextField(
//                 name: 'memo',
//                 controller: _memoController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Memo',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     var typeExpense = _formKey.currentState?.value['transactionType'];
//                     var date = _formKey.currentState?.value['date'];
//                     var category = _formKey.currentState?.value['category'];
//                     var amount = _amountController.text;
//                     var memo = _memoController.text;
//
//                     // Get category ID
//                     int? typeTransactionId = await DatabaseManagement.instance.getTypeTransactionId(
//                       category,
//                     );
//
//                     if (typeTransactionId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Invalid category selected.'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     Map<String, dynamic> row = {
//                       'date_user': date.toString(),
//                       'amount_transaction': double.parse(amount),
//                       'type_expense': typeExpense == '1' ? 1 : 0,
//                       'memo_transaction': memo,
//                       'ID_type_transaction': typeTransactionId,
//                     };
//
//                     await DatabaseManagement.instance.insertTransaction(row);
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//แก้รอบที่ล้านตอนตี1.35
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'pick_picture.dart';
import '../database/db_manage.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  final String? imageUri; // เพิ่มจากของนุ้ก

  AddTransaction({Key? key, this.imageUri}) : super(key: key);// เพิ่มจากของนุ้ก

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  final ImageOcrHelper _imageOcrHelper = ImageOcrHelper();  // สร้างอินสแตนซ์ของ ImageOcrHelper พอย

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _pickImageAndExtractText() async { //พอย
    final extractedText = await _imageOcrHelper.pickImageAndExtractText(); //ผลลัพธ์ที่ได้จะถูกเก็บในตัวแปร extractedText อยู่ในไฟล์ pick_picture.dart
    if (extractedText != null) { //ตรวจสอบว่า OCR สามารถดึงข้อความออกมาได้มั้ย
      setState(() {
        _amountController.text = extractedText; //เปลี่ยนข้อความ ี่แสดงใน TextField เป็นข้อความที่ดึงมาจาก OCR
      });
    }
  }

  Future<void> _handleIncomingImage(String imageUri) async { //พอย
    final extractedText = await _imageOcrHelper.extractTextFromImage(imageUri);
    if (extractedText != null) {
      setState(() {
        _amountController.text = extractedText; // กำหนดค่าที่กรอกเงิน
      });
    }
  }

  @override //พอย
  void initState() {
    super.initState();

    // ตรวจสอบว่ามีค่า imageUri มั้ย
    if (widget.imageUri != null && widget.imageUri!.isNotEmpty) {
      _handleIncomingImage(widget.imageUri!); // เรียกใช้ฟังก์ชันที่จัดการกับภาพที่แชร์
    }

    // เพิ่มการตั้งค่าที่นี่เพื่อรับข้อมูลจากการแชร์
    const MethodChannel channel = MethodChannel("vongola");
    channel.setMethodCallHandler((call) async {
      if (call.method == 'shareImage') {
        final String imageUri = call.arguments; // รับค่า imageUri จากการแชร์
        await _handleIncomingImage(imageUri); // เรียกฟังก์ชันเพื่อจัดการกับภาพที่แชร์
      }
    });
  }

  @override //นุ้ก
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense & Income Log'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderDropdown<String>(
                name: 'transactionType',
                decoration: InputDecoration(
                  labelText: 'Select Transaction Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Income', 'Expense']
                    .map((type) => DropdownMenuItem(
                  value: type == 'Income' ? '1' : '0',
                  child: Text(type),
                ))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 10),

              FormBuilderDateTimePicker(
                name: 'date',
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 10),


              FormBuilderDropdown<String>(
                name: 'category',
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(),
                ),
                items: ['Food', 'Car fare', 'Gasoline cost', 'Cost of equipment', 'Other']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'amount',
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Enter Amount of Money',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number, //พอย
                      validator: FormBuilderValidators.compose([//ใช้ FormBuilderValidators.composeตรวจสอบความถูกต้องของข้อมูลที่ผู้ใช้กรอก
                        FormBuilderValidators.required(),//FormBuilderValidators.required()ใช้เพื่อไม่ให้ปล่อยช่องให้ว่าง
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: _pickImageAndExtractText,
                  ),
                ],
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'memo',
                controller: _memoController,
                decoration: InputDecoration(
                  labelText: 'Enter Memo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    var typeExpense = _formKey.currentState?.value['transactionType'];
                    var date = _formKey.currentState?.value['date'];
                    var category = _formKey.currentState?.value['category'];
                    var amount = _amountController.text;
                    var memo = _memoController.text;

                    // Get category ID
                    int? typeTransactionId = await DatabaseManagement.instance.getTypeTransactionId(
                      category,
                    );

                    if (typeTransactionId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid category selected.'),
                        ),
                      );
                      return;
                    }

                    Map<String, dynamic> row = {
                      'date_user': date.toString(),
                      'amount_transaction': double.parse(amount),
                      'type_expense': typeExpense == '1' ? 1 : 0,
                      'memo_transaction': memo,
                      'ID_type_transaction': typeTransactionId,
                    };

                    await DatabaseManagement.instance.insertTransaction(row);
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//*******************************************************************************
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'pick_picture.dart';
// import '../database/db_manage.dart';
//
// class AddTransaction extends StatefulWidget {
//   @override
//   _AddTransactionState createState() => _AddTransactionState();
// }
//
// class _AddTransactionState extends State<AddTransaction> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _memoController = TextEditingController();
//   final ImageOcrHelper _imageOcrHelper = ImageOcrHelper();
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _memoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // ฟังการแชร์ภาพ
//     ReceiveSharingIntent.instance.getMediaStream().listen((List<SharedMediaFile> value) {
//       if (value.isNotEmpty) {
//         _extractTextFromImage(value.first.path); // รับเส้นทางของภาพแรก
//       }
//     });
//   }
//
//   Future<void> _extractTextFromImage(String path) async {
//     final extractedText = await _imageOcrHelper.extractTextFromImage(path);
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText; // อัปเดตค่าใน TextField
//       });
//     }
//   }
//
//   Future<void> _pickImageAndExtractText() async {
//     final extractedText = await _imageOcrHelper.pickImageAndExtractText();
//     if (extractedText != null) {
//       setState(() {
//         _amountController.text = extractedText;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expense & Income Log'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: FormBuilder(
//           key: _formKey,
//           child: Column(
//             children: [
//               FormBuilderDropdown<String>(
//                 name: 'transactionType',
//                 decoration: InputDecoration(
//                   labelText: 'Select Transaction Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Income', 'Expense']
//                     .map((type) => DropdownMenuItem(
//                   value: type == 'Income' ? '1' : '0',
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDateTimePicker(
//                 name: 'date',
//                 inputType: InputType.date,
//                 decoration: InputDecoration(
//                   labelText: 'Select Date',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               FormBuilderDropdown<String>(
//                 name: 'category',
//                 decoration: InputDecoration(
//                   labelText: 'Select Category',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Food', 'Car fare', 'Gasoline cost', 'Cost of equipment', 'Other']
//                     .map((category) => DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 ))
//                     .toList(),
//                 validator: FormBuilderValidators.required(),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: FormBuilderTextField(
//                       name: 'amount',
//                       controller: _amountController,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Amount of Money',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: FormBuilderValidators.compose([
//                         FormBuilderValidators.required(),
//                         FormBuilderValidators.numeric(),
//                       ]),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.photo),
//                     onPressed: _pickImageAndExtractText,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               FormBuilderTextField(
//                 name: 'memo',
//                 controller: _memoController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Memo',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.saveAndValidate()) {
//                     var typeExpense = _formKey.currentState?.value['transactionType'];
//                     var date = _formKey.currentState?.value['date'];
//                     var category = _formKey.currentState?.value['category'];
//                     var amount = _amountController.text;
//                     var memo = _memoController.text;
//
//                     // Get category ID
//                     int? typeTransactionId = await DatabaseManagement.instance.getTypeTransactionId(
//                       category,
//                     );
//
//                     if (typeTransactionId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Invalid category selected.'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     Map<String, dynamic> row = {
//                       'date_user': date.toString(),
//                       'amount_transaction': double.parse(amount),
//                       'type_expense': typeExpense == '1' ? 1 : 0,
//                       'memo_transaction': memo,
//                       'ID_type_transaction': typeTransactionId,
//                     };
//
//                     await DatabaseManagement.instance.insertTransaction(row);
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
