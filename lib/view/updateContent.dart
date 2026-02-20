import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';

class UpdateContentPage extends StatefulWidget {
  String content;

  UpdateContentPage({required this.content});

  @override
  State<UpdateContentPage> createState() => _UpdateContentPageState();
}

class _UpdateContentPageState extends State<UpdateContentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    // نعبي الـ controller بالمحتوى الحالي
    contentController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تحديث الملاحظات"),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: "الملاحظات",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 5,
                validator: (val) =>
                    (val == null || val.isEmpty) ? "ادخل الملاحظات" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.mainColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // نرجع المحتوى الجديد للصفحة السابقة
                    Navigator.pop(context, contentController.text);
                  }
                },
                child: const Text(
                  "حفظ التحديث",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
