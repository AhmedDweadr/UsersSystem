import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة مستخدم"),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "الاسم",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) =>
                    (val == null || val.isEmpty) ? "ادخل الاسم" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "التليفون",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    (val == null || val.isEmpty) ? "ادخل التليفون" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "العنوان",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (val) =>
                    (val == null || val.isEmpty) ? "ادخل العنوان" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: "الملاحظات",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // نرجع البيانات للصفحة السابقة
                    Navigator.pop(context, {
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "address": addressController.text,
                      "content": contentController.text,
                    });
                  }
                },
                child: const Text(
                  "حفظ المستخدم",
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
