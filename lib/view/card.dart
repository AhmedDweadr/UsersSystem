import 'package:flutter/material.dart';
import 'package:my_app/core/themes/themes.dart';

class card extends StatelessWidget {
  const card({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: Themes.SecondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Themes.mainColor,
                child: const Text(
                  "ا",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              title: const Text(
                "احمد محمد",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("حوش عيسى"),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("0109045556", style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 6),
                  Icon(Icons.call, color: Colors.blue, size: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
