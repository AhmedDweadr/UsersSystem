import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/Cubit.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/State.dart';
import 'package:my_app/core/themes/themes.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("خطأ"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("نجاح"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // يغلق الـ dialog
              Navigator.pop(context, true); // يرجع للصفحة السابقة
            },
            child: const Text("موافق"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<userCubit, UserState>(
      listener: (context, state) {
        if (state is userError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showError(state.Message);
          });
        }

        if (state is userAddedSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSuccess(state.message);
          });
        }
      },
      child: Scaffold(
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
                      val == null || val.isEmpty ? "ادخل الاسم" : null,
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
                      val == null || val.isEmpty ? "ادخل التليفون" : null,
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
                      val == null || val.isEmpty ? "ادخل العنوان" : null,
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
                BlocBuilder<userCubit, UserState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Themes.mainColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<userCubit>().addUser(
                                name: nameController.text,
                                address: addressController.text,
                                phone: phoneController.text,
                                content: [contentController.text],
                              );
                        }
                      },
                      child: const Text(
                        "حفظ المستخدم",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}