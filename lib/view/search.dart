import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, String>> users = [
    {
      "name": "احمد محمد",
      "phone": "0109045556",
      "address": "حوش عيسى",
      "content": "ملاحظات افتراضية",
    },
    {
      "name": "محمد علي",
      "phone": "0111222333",
      "address": "المنصورة",
      "content": "ملاحظات ثانية",
    },
  ];

  List<Map<String, String>> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users);
    searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(users);
      } else {
        filteredUsers = users
            .where(
              (user) =>
                  user["name"]!.toLowerCase().contains(query) ||
                  user["address"]!.toLowerCase().contains(query) ||
                  user["content"]!.toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "ابحث بالاسم، العنوان أو الملاحظات...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    title: Text(
                      user["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${user["address"]!}\n${user["content"]!}"),
                    isThreeLine: true,
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user["phone"]!,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        Icon(Icons.call, color: Themes.mainColor, size: 20),
                      ],
                    ),
                    onTap: () async {
                      // final updatedContent = await Navigator.push<String>(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => UpdateContentPage(user: user),
                      //   ),
                      // );
                      // if (updatedContent != null) {
                      //   setState(() {
                      //     final originalIndex = users.indexOf(user);
                      //     users[originalIndex]["content"] = updatedContent;
                      //     _filterUsers();
                      //   });
                      // }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
