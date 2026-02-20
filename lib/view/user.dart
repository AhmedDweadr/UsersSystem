import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';
import 'package:my_app/view/updateContent.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> user;

  UserDetails({super.key, required this.user});

  final List<Map<String, dynamic>> history = const [
    {
      "date": "19-02-2026",
      "days": 5,
      "note": "عمل صيانة عمل صيانة عمل صيانة عمل صيانة عمل صيانة",
    },
    {"date": "15-02-2026", "days": 3, "note": "إجازة"},
    {"date": "10-02-2026", "days": 7, "note": "مهمة خارجية"},

    {"date": "15-02-2026", "days": 3, "note": "إجازة"},
    {"date": "10-02-2026", "days": 7, "note": "مهمة خارجية"},
    {"date": "15-02-2026", "days": 3, "note": "إجازة"},
    {"date": "10-02-2026", "days": 7, "note": "مهمة خارجية"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// 🔹 AppBar فيه بيانات المستخدم
          SliverAppBar(
            backgroundColor: Themes.mainColor,
            expandedHeight: 135,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(user["phone"], style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 5),
                    Text(user["address"]),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 ليست التاريخ
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = history[index];

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.calendar_today, color: Themes.mainColor),
                            const SizedBox(width: 8),
                            Text(
                              item["date"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UpdateContentPage(content: item["note"]),
                                    ),
                                  );
                              },
                              icon: Icon(Icons.edit, color: Themes.mainColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete, color: Themes.mainColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item["note"],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 20, 17, 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: history.length),
          ),
        ],
      ),
    );
  }
}
