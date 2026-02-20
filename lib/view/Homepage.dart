import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';
import 'package:my_app/view/AddUser.dart';
import 'package:my_app/view/search.dart';
import 'package:my_app/view/user.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // قائمة المستخدمين كـ Map
  List<Map<String, String>> users = [
    {"name": "احمد محمد", "phone": "0109045556", "address": "حوش عيسى"},
    {"name": "محمد علي", "phone": "0111222333", "address": "المنصورة"},
    {"name": "سارة خالد", "phone": "0123456789", "address": "القاهرة"},
    {"name": "محمود حسن", "phone": "0112233445", "address": "الإسكندرية"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchPage()),
            );
          },
          icon: const Icon(Icons.search, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // إضافة مستخدم جديد (يمكنك تعديل هذا ليظهر صفحة إضافة المستخدم)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddUserPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: Themes.SecondColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Themes.mainColor,
                child: Text(
                  user["name"]!.substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              title: Text(
                user["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(user["address"]!),
              isThreeLine: true,
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user["phone"]!, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 6),
                  Icon(Icons.call, color: Themes.mainColor, size: 20),
                ],
              ),
              onTap: () {
                // تمرير بيانات المستخدم للصفحة
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserDetails(user: user)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
