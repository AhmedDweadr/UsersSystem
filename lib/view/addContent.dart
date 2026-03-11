import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentCubit.dart';
import 'package:my_app/core/themes/themes.dart';

class Addcontent extends StatefulWidget {
  Addcontent({super.key, required this.user_id});

  final String user_id;
  @override
  State<Addcontent> createState() => _UpdateContentPageState();
}

class _UpdateContentPageState extends State<Addcontent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    // نعبي الـ controller بالمحتوى الحالي
    contentController = TextEditingController();
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
        title: const Text("اضافه الملاحظات"),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await context.read<ContentCubit>().AddContent(
                      contentController.text,
                      widget.user_id,
                    );
                    // نرجع المحتوى الجديد للصفحة السابقة
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                child: const Text("حفظ", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
